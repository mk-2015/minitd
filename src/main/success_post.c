#include <minit/configreader.h>
#include <minit/service.h>
#include <minit/process.h>
#include <minit/api.h>

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <errno.h>
#include <ctype.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <stdbool.h>

static void free_string_array(char **items)
{
    if (!items) return;
    for (size_t i = 0; items[i] != NULL; i++) {
        free(items[i]);
    }
    free(items);
}

static char **parse_exec_args(const char *exec_cmd, char **out_binary_path)
{
    if (!exec_cmd || !out_binary_path) return NULL;

    int capacity = 8;
    int count = 0;
    char **argv = calloc(capacity, sizeof(char *));
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
                free_string_array(argv);
                free(cmd_copy);
                return NULL;
            }
            argv = new_argv;
        }

        argv[count++] = strdup(token_start);
    }

    argv[count] = NULL;
    if (count > 0) {
        *out_binary_path = strdup(argv[0]);
    } else {
        *out_binary_path = NULL;
    }

    free(cmd_copy);
    return argv;
}

static int spawn_default_shell(void)
{
    printf("[ INFO ] Spawning fallback shell (/bin/sh)\n");
    char *binary_path = strdup("/bin/sh");
    if (!binary_path) return -1;

    char *argv[] = { "/bin/sh", NULL };
    ProcessNode *process = process_create("FallbackShell", binary_path, argv, PROCESS_ALWAYS, 0);
    if (!process) {
        free(binary_path);
        return -1;
    }

    pid_t pid = fork();
    if (pid < 0) {
        perror("[ FAIL ] Fork failed");
        free(binary_path);
        return -1;
    }

    if (pid == 0) {
        int fd = open("/dev/console", O_RDWR);
        if (fd >= 0) {
            dup2(fd, STDIN_FILENO);
            dup2(fd, STDOUT_FILENO);
            dup2(fd, STDERR_FILENO);
            if (fd > STDERR_FILENO) close(fd);
            setsid();
            ioctl(STDIN_FILENO, TIOCSCTTY, 1);
        }
        execvp(binary_path, argv);
        perror("[ FAIL ] execvp failed");
        _exit(EXIT_FAILURE);
    }

    process->pid = pid;
    process->is_active = 1;
    free(binary_path);
    return 0;
}

int __post_success(void)
{
    MiConfig *cfg = open_config("/etc/minitd/startexec.conf");
    if (!cfg) {
        printf("[ WARN ] /etc/minitd/startexec.conf not found. Spawning default shell.\n");
        return spawn_default_shell();
    }

    char **sections = list_sections(cfg);
    if (!sections) {
        printf("[ WARN ] No sections in startexec.conf. Spawning default shell.\n");
        close_config(cfg);
        return spawn_default_shell();
    }

    bool found_exec = false;

    for (size_t i = 0; sections[i] != NULL; i++) {
        char *section = sections[i];
        char key[256];

        /* Check for IGNORE=1 key */
        snprintf(key, sizeof(key), "%s.IGNORE", section);
        char *ignore_val = readkey(cfg, key);
        if (ignore_val) {
            int ignore = atoi(ignore_val);
            free(ignore_val);
            if (ignore == 1) continue;
        }

        snprintf(key, sizeof(key), "%s.Exec", section);
        char *exec_cmd = readkey(cfg, key);
        if (!exec_cmd) continue;

        snprintf(key, sizeof(key), "%s.Policy", section);
        char *policy = readkey(cfg, key);
        if (!policy) policy = strdup("once");

        snprintf(key, sizeof(key), "%s.Name", section);
        char *name = readkey(cfg, key);
        if (!name) name = strdup(section);

        ProcessType ptype = PROCESS_ONCE;
        if (policy && strcmp(policy, "always") == 0) {
            ptype = PROCESS_ALWAYS;
        }

        char *binary_path = NULL;
        char **argv = parse_exec_args(exec_cmd, &binary_path);
        if (!argv || !binary_path) {
            fprintf(stderr, "[ FAIL ] Failed to parse exec command for section [%s]\n", section);
            free(exec_cmd);
            free(policy);
            free(name);
            free_string_array(argv);
            free(binary_path);
            continue;
        }

        found_exec = true;


        printf("[ INFO ] Section=[%s] Name=%s Policy=%s Binary=%s Argv0=%s\n",
               section, name, policy, binary_path, argv[0] ? argv[0] : "(null)");
        
        if(new_tty(NULL) == -1) {
            fprintf(stderr, "[ WARN ] Failed to create new TTY for section [%s]\n", section);
        }
        ProcessNode *process = process_create(name, binary_path, argv, ptype, 0);
        if (!process) {
            fprintf(stderr, "[ FAIL ] Failed to create process node for %s\n", name);
        } else if (process_spawn(process) != 0) {
            fprintf(stderr, "[ FAIL ] Failed to spawn process %s\n", name);
        }

        free(exec_cmd);
        free(policy);
        free(name);
        free_string_array(argv);
        free(binary_path);
    }

    free_string_array(sections);
    close_config(cfg);

    /* Fallback if no valid Exec keys were executed */
    if (!found_exec) {
        printf("[ WARN ] No valid Exec keys executed from startexec.conf. Spawning fallback shell.\n");
        return spawn_default_shell();
    }

    return 0;
}