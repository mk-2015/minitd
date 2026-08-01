#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <signal.h>
#include <unistd.h>
#include <ctype.h>

#include <minit/service.h>
#include <minit/process.h>

static int g_next_service_id = 1;

extern ServiceIndex *ServiceTable;
extern size_t ServiceTableCapacity;
extern size_t ServiceTableCount;

static void free_parsed_argv(char **argv);

static char **parse_exec_args(const char *exec_cmd, char **out_binary_path) {
    if (!exec_cmd || strlen(exec_cmd) == 0) return NULL;

    int capacity = 8;
    int count = 0;
    char **argv = malloc(capacity * sizeof(char *));
    if (!argv) return NULL;
    
    char *cmd_copy = strdup(exec_cmd);
    if (!cmd_copy) {
        free(argv);
        return NULL;
    }
    char *p = cmd_copy;

    while (*p) {
        while (*p && isspace((unsigned char)*p)) p++;
        if (!*p) break;

        char *token_start = p;
        char quote = 0;

        if (*p == '"' || *p == '\'') {
            quote = *p;
            p++;
            token_start = p;
            while (*p && *p != quote) p++;
        } else {
            while (*p && !isspace((unsigned char)*p)) p++;
        }

        if (*p) {
            *p = '\0';
            p++;
        }

        if (count >= capacity - 1) {
            capacity *= 2;
            char **new_argv = realloc(argv, capacity * sizeof(char *));
            if (!new_argv) {
                free_parsed_argv(argv);
                free(cmd_copy);
                return NULL;
            }
            argv = new_argv;
        }

        argv[count++] = strdup(token_start);
    }

    argv[count] = NULL;
    free(cmd_copy);

    if (count > 0 && out_binary_path) {
        *out_binary_path = strdup(argv[0]);
    }

    return argv;
}

static void free_parsed_argv(char **argv) {
    if (!argv) return;
    for (int i = 0; argv[i]; i++) free(argv[i]);
    free(argv);
}

ServiceIndex CreateService(ServicePolicy sp, const char *exec_file_path, const char *name, const char *run_target, const char *state_target, const char *wants, const char *requires, const char *after, const char *before, ServiceUnitType type, RestartPolicy restart) {
    ServiceIndex si;
    si.serviceid = g_next_service_id++;
    si.sp = sp;
    si.pid = -1;
    si.proctable_id = 0;
    si.name = name ? strdup(name) : NULL;
    si.exec_file_path = exec_file_path ? strdup(exec_file_path) : NULL;
    si.run_target = run_target ? strdup(run_target) : NULL;
    si.state_target = state_target ? strdup(state_target) : NULL;
    si.wants = wants ? strdup(wants) : NULL;
    si.requires = requires ? strdup(requires) : NULL;
    si.after = after ? strdup(after) : NULL;
    si.before = before ? strdup(before) : NULL;
    si.type = type;
    si.restart = restart;
    si.state = SERVICE_STATE_INACTIVE;
    return si;
}

int FreeServiceIndex(ServiceIndex *si) {
    if (!si) return 0;
    if (si->name) {
        free((char *)si->name);
        si->name = NULL;
    }
    if (si->exec_file_path) {
        free((char *)si->exec_file_path);
        si->exec_file_path = NULL;
    }
    if (si->run_target) {
        free((char *)si->run_target);
        si->run_target = NULL;
    }
    if (si->state_target) {
        free((char *)si->state_target);
        si->state_target = NULL;
    }
    if (si->wants) {
        free((char *)si->wants);
        si->wants = NULL;
    }
    if (si->requires) {
        free((char *)si->requires);
        si->requires = NULL;
    }
    if (si->after) {
        free((char *)si->after);
        si->after = NULL;
    }
    if (si->before) {
        free((char *)si->before);
        si->before = NULL;
    }
    return 1;
}

int RegisterService(ServiceIndex *si) {
    if (!si || !si->exec_file_path || !si->name) return 0;

    if (ServiceTableCount >= ServiceTableCapacity) {
        size_t new_cap = (ServiceTableCapacity == 0) ? 8 : ServiceTableCapacity * 2;
        ServiceIndex *new_table = realloc(ServiceTable, new_cap * sizeof(ServiceIndex));
        if (!new_table) {
            perror("[ FAIL ] Failed to reallocate ServiceTable");
            return 0;
        }
        ServiceTable = new_table;
        ServiceTableCapacity = new_cap;
    }

    ProcessType ptype = (si->sp == SERVICE_ALWAYS) ? PROCESS_ALWAYS : PROCESS_ONCE;

    char *binary_path = NULL;
    char **parsed_argv = parse_exec_args(si->exec_file_path, &binary_path);

    if (!parsed_argv || !binary_path) {
        if (parsed_argv) free_parsed_argv(parsed_argv);
        return 0;
    }

    ProcessNode *node = process_create(si->name, binary_path, parsed_argv, ptype, 1);
    
    free(binary_path);
    free_parsed_argv(parsed_argv);

    if (!node) return 0;

    si->proctable_id = node->id;

    if (ServiceTableCount >= ServiceTableCapacity) {
        size_t new_cap = (ServiceTableCapacity == 0) ? 4 : ServiceTableCapacity * 2;
        ServiceIndex *new_table = realloc(ServiceTable, new_cap * sizeof(ServiceIndex));
        if (!new_table) {
            return 0;
        }
        ServiceTable = new_table;
        ServiceTableCapacity = new_cap;
    }

    ServiceTable[ServiceTableCount++] = *si;
    return 1;
}

int StartService(ServiceIndex *si) {
    if (!si) return -1;

    ServiceIndex *target = NULL;
    for (size_t i = 0; i < ServiceTableCount; i++) {
        if (ServiceTable[i].serviceid == si->serviceid) {
            target = &ServiceTable[i];
            break;
        }
    }

    ProcessNode *node = process_find_by_id(si->proctable_id);
    if (!node) {
        return -1;
    }

    if (process_spawn(node) == 0) {
        si->pid = node->pid;
        if (target) {
            target->pid = node->pid;
        }
        printf("[ OK ] Started service '%s' (ID: %d, PID: %d)\n", si->name, si->serviceid, si->pid);
        return si->serviceid;
    }
    return -1;
}

int StopService(int serviceid) {
    for (size_t i = 0; i < ServiceTableCount; i++) {
        if (ServiceTable[i].serviceid == serviceid) {
            ProcessNode *node = process_find_by_id(ServiceTable[i].proctable_id);
            if (node && node->is_active && node->pid > 0) {
                kill(node->pid, SIGTERM);
                ServiceTable[i].pid = -1;
                return 1;
            }
        }
    }
    return 0;
}

int UnregisterService(int serviceid) {
    for (size_t i = 0; i < ServiceTableCount; i++) {
        if (ServiceTable[i].serviceid == serviceid) {
            StopService(serviceid);

            FreeServiceIndex(&ServiceTable[i]);

            for (size_t j = i; j < ServiceTableCount - 1; j++) {
                ServiceTable[j] = ServiceTable[j + 1];
            }

            ServiceTableCount--;
            return 1;
        }
    }
    return 0;
}

int StopAllServices(void) {
    int stopped_count = 0;
    ProcessNode *curr = process_list_head;

    printf("[ INFO ] Terminating all active services...\n");

    while (curr) {
        if (curr->is_active && curr->pid > 0) {
            if (kill(curr->pid, SIGTERM) == 0) {
                stopped_count++;
            }
        }
        curr = curr->next;
    }

    if (stopped_count == 0) {
        printf("[ INFO ] No active services to stop.\n");
        return 0;
    }

    usleep(500000);

    curr = process_list_head;
    while (curr) {
        if (curr->is_active && curr->pid > 0) {
            kill(curr->pid, SIGKILL);
        }
        curr = curr->next;
    }

    for (size_t i = 0; i < ServiceTableCount; i++) {
        ServiceTable[i].pid = -1;
    }

    return stopped_count;
}