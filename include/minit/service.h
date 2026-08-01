#ifndef MINIT_SERVICE_H
#define MINIT_SERVICE_H

#include <stddef.h>

typedef enum {
    SERVICE_ONCE,
    SERVICE_ALWAYS,
    SERVICE_CRITICAL,
} ServicePolicy;

typedef enum {
    SERVICE_TYPE_SIMPLE,
    SERVICE_TYPE_ONESHOT,
    SERVICE_TYPE_FORKING,
    SERVICE_TYPE_NOTIFY,
} ServiceUnitType;

typedef enum {
    RESTART_NO,
    RESTART_ON_FAILURE,
    RESTART_ALWAYS,
} RestartPolicy;

typedef enum {
    SERVICE_STATE_INACTIVE,
    SERVICE_STATE_STARTING,
    SERVICE_STATE_RUNNING,
    SERVICE_STATE_FAILED,
    SERVICE_STATE_STOPPED,
} ServiceState;

typedef struct {
    int serviceid;
    ServicePolicy sp;
    int pid;
    size_t proctable_id;
    const char *name;
    const char *exec_file_path;
    const char *run_target;    /* e.g. "graphical.target" */
    const char *state_target;  /* e.g. "graphical-multiuser.target" */
    const char *wants;         /* comma-separated unit names */
    const char *requires;      /* comma-separated unit names */
    const char *after;         /* comma-separated unit names */
    const char *before;        /* comma-separated unit names */
    ServiceUnitType type;
    RestartPolicy restart;
    ServiceState state;
} ServiceIndex;

/* Global Service Table Exports */
extern ServiceIndex *ServiceTable;
extern size_t ServiceTableCapacity;
extern size_t ServiceTableCount;

/* Lifecycle APIs */
ServiceIndex CreateService(ServicePolicy sp, const char *exec_file_path, const char *name, const char *run_target, const char *state_target, const char *wants, const char *requires, const char *after, const char *before, ServiceUnitType type, RestartPolicy restart);
int FreeServiceIndex(ServiceIndex *si);

int RegisterService(ServiceIndex *si);
int StartService(ServiceIndex *si);
int StopService(int serviceid);
int StopAllServices(void);
int UnregisterService(int serviceid);

#endif /* MINIT_SERVICE_H */