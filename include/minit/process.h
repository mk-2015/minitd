#ifndef MINIT_PROCESS_H
#define MINIT_PROCESS_H

#include <sys/types.h>
#include <stddef.h>

typedef enum {
    PROCESS_ONCE,
    PROCESS_ALWAYS,
    PROCESS_CRITICAL
} ProcessType;

typedef struct ProcessNode {
    size_t id;
    char *name;
    char *path;
    char **argv;
    ProcessType type;
    pid_t pid;
    int is_active;
    int is_primary;
    
    
    struct ProcessNode *next;
    struct ProcessNode *prev;
} ProcessNode;

extern ProcessNode *process_list_head;

ProcessNode *process_create(const char *name, const char *path, char *const argv[], ProcessType type, int is_primary);
int process_spawn(ProcessNode *proc);
int process_remove(size_t id);
ProcessNode *process_find_by_pid(pid_t pid);
ProcessNode *process_find_by_id(size_t id);

size_t process_count_primaries(void);
int process_has_had_primaries(void);

void handle_process_exit(pid_t pid, int status);

int new_tty(const char *path);

#endif /* MINIT_PROCESS_H */