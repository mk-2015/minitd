#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/wait.h>
#include <minit/process.h>
#include <minit/api.h>
#include <minit/service.h>

ProcessNode *process_list_head = NULL;
static size_t next_process_id = 1;
static int g_had_primaries = 0;

extern ServiceIndex *ServiceTable;
extern size_t ServiceTableCapacity;
extern size_t ServiceTableCount;

extern volatile sig_atomic_t g_shutdown_requested;
extern volatile sig_atomic_t g_reboot_requested;

/* Helper to clone argv arrays dynamically */
static char **clone_argv(char *const argv[]) {
    if (!argv) return NULL;
    size_t count = 0;
    while (argv[count]) count++;

    char **new_argv = malloc((count + 1) * sizeof(char *));
    for (size_t i = 0; i < count; i++) {
        new_argv[i] = strdup(argv[i]);
    }
    new_argv[count] = NULL;
    return new_argv;
}

/* Helper to free argv */
static void free_argv(char **argv) {
    if (!argv) return;
    for (size_t i = 0; argv[i] != NULL; i++) {
        free(argv[i]);
    }
    free(argv);
}

size_t process_count_primaries(void) {
    size_t count = 0;
    ProcessNode *curr = process_list_head;

    while (curr) {
        if (curr->is_primary) {
            count++;
        }
        curr = curr->next;
    }
    return count;
}

int process_has_had_primaries(void) {
    return g_had_primaries;
}

/* Register a new dynamic process into the linked list */
ProcessNode *process_create(const char *name, const char *path, char *const argv[], ProcessType type, int is_primary) {
    ProcessNode *proc = calloc(1, sizeof(ProcessNode));
    if (!proc) return NULL;

    proc->id = next_process_id++;
    proc->name = strdup(name);
    proc->path = strdup(path);
    proc->argv = clone_argv(argv);
    proc->type = type;
    proc->pid = -1;
    proc->is_primary = is_primary;
    proc->is_active = 0;
    if (proc->is_primary) {
        g_had_primaries = 1;
    }

    /* Insert at head of double-linked list */
    proc->next = process_list_head;
    if (process_list_head) {
        process_list_head->prev = proc;
    }
    process_list_head = proc;

    printf("[ OK ] Created process '%s' (ID: %zu)\n", proc->name, proc->id);
    return proc;
}

/* Spawn a dynamic process */
int process_spawn(ProcessNode *proc) {
    if (!proc) return -1;

    pid_t pid = fork();
    if (pid < 0) {
        perror("[ FAIL ] Fork failed");
        return -1;
    }

    if (pid == 0) {
        /* Child process */
        execvp(proc->path, proc->argv);
        perror("[ FAIL ] Execvp failed");
        exit(EXIT_FAILURE);
    }

    /* Parent process */
    proc->pid = pid;
    proc->is_active = 1;
    return 0;
}

/* Find process by PID */
ProcessNode *process_find_by_pid(pid_t pid) {
    ProcessNode *curr = process_list_head;
    while (curr) {
        if (curr->pid == pid && curr->is_active) {
            return curr;
        }
        curr = curr->next;
    }
    return NULL;
}

/* Find process by ID */
ProcessNode *process_find_by_id(size_t id) {
    ProcessNode *curr = process_list_head;
    while (curr) {
        if (curr->id == id) {
            return curr;
        }
        curr = curr->next;
    }
    return NULL;
}

/* Remove and unregister a dynamic process */
int process_remove(size_t id) {
    ProcessNode *proc = process_find_by_id(id);
    if (!proc) return -1;

    if (proc->prev) proc->prev->next = proc->next;
    if (proc->next) proc->next->prev = proc->prev;
    if (process_list_head == proc) process_list_head = proc->next;

    free(proc->name);
    free(proc->path);
    free_argv(proc->argv);
    free(proc);

    return 0;
}

/* Dynamic lifecycle exit handler */
void handle_process_exit(pid_t pid, int status) {
    (void)status; /* Unused parameter warning suppression */

    ProcessNode *proc = process_find_by_pid(pid);
    if (!proc) return;

    proc->is_active = 0;

    /* 1. Sync ServiceTable entry if this PID maps to a registered Service */
    for (size_t i = 0; i < ServiceTableCount; i++) {
        if (ServiceTable[i].proctable_id == proc->id) {
            ServiceTable[i].pid = -1;
            break;
        }
    }

    /* 2. Don't restart or process primary exits if system is shutting down */
    if (g_system_state != MINIT_STATE_RUNNING) {
        process_remove(proc->id);
        return;
    }

    size_t id = proc->id;

    switch (proc->type) {
        case PROCESS_ONCE:
            if (proc->is_primary && process_count_primaries() == 1 && g_had_primaries) {
                if (!g_reboot_requested) {
                    g_shutdown_requested = 1;
                }
            }
            process_remove(id);
            break;

        case PROCESS_ALWAYS: {
            int should_restart = 1;
            int exit_code = WEXITSTATUS(status);
            if (WIFEXITED(status) && exit_code == 0) {
                should_restart = 0;
            }

            ServiceIndex *svc = NULL;
            for (size_t i = 0; i < ServiceTableCount; i++) {
                if (ServiceTable[i].proctable_id == id) {
                    svc = &ServiceTable[i];
                    break;
                }
            }

            if (svc && svc->restart == RESTART_NO) {
                should_restart = 0;
            } else if (svc && svc->restart == RESTART_ON_FAILURE) {
                should_restart = !(WIFEXITED(status) && exit_code == 0);
            }

            if (should_restart) {
                process_spawn(proc);
                for (size_t i = 0; i < ServiceTableCount; i++) {
                    if (ServiceTable[i].proctable_id == id) {
                        ServiceTable[i].pid = proc->pid;
                        ServiceTable[i].state = SERVICE_STATE_RUNNING;
                        break;
                    }
                }
            } else {
                if (svc) {
                    svc->state = SERVICE_STATE_FAILED;
                }
                process_remove(id);
            }
            break;
        }

        case PROCESS_CRITICAL:
            mpanic("Critical PID 1 service crashed!");
            mreboot();
            break;
    }
}