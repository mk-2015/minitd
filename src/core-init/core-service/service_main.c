#include<minit/api.h>
#include<minit/service.h>
#include<minit/process.h>
#include<minit/configreader.h>

#include<unistd.h>
#include<ctype.h>
#include<stdio.h>
#include<stdlib.h>
#include<errno.h>
#include <dirent.h>
#include <stdint.h>
#include <stdbool.h>
#include <string.h>
#include<sys/types.h>

ServiceIndex *ServiceTable = NULL;
size_t ServiceTableCapacity = 0;
size_t ServiceTableCount = 0;

static int service_index_by_name(const char *name) {
    if (!name) return -1;
    for (size_t i = 0; i < ServiceTableCount; i++) {
        if (ServiceTable[i].name && strcmp(ServiceTable[i].name, name) == 0) {
            return (int)i;
        }
    }
    return -1;
}

static bool service_active_or_running(ServiceIndex *si) {
    return si && (si->state == SERVICE_STATE_RUNNING || si->state == SERVICE_STATE_STARTING);
}

static bool service_matches_target(ServiceIndex *si, const char *target_name) {
    if (!si) return false;
    if (!si->run_target || si->run_target[0] == '\0') return true;
    return strcmp(si->run_target, target_name) == 0;
}

static bool service_requires_satisfied(ServiceIndex *si) {
    if (!si || !si->requires) return true;

    char *copy = strdup(si->requires);
    if (!copy) return false;
    char *saveptr = NULL;
    char *token = strtok_r(copy, ",", &saveptr);
    while (token) {
        char *dep = token;
        while (*dep && isspace((unsigned char)*dep)) dep++;
        char *end = dep + strlen(dep) - 1;
        while (end >= dep && isspace((unsigned char)*end)) *end-- = '\0';
        int idx = service_index_by_name(dep);
        if (idx < 0 || !service_active_or_running(&ServiceTable[idx])) {
            free(copy);
            return false;
        }
        token = strtok_r(NULL, ",", &saveptr);
    }
    free(copy);
    return true;
}

static bool service_after_satisfied(ServiceIndex *si) {
    if (!si || !si->after) return true;

    char *copy = strdup(si->after);
    if (!copy) return false;
    char *saveptr = NULL;
    char *token = strtok_r(copy, ",", &saveptr);
    while (token) {
        char *dep = token;
        while (*dep && isspace((unsigned char)*dep)) dep++;
        char *end = dep + strlen(dep) - 1;
        while (end >= dep && isspace((unsigned char)*end)) *end-- = '\0';
        int idx = service_index_by_name(dep);
        if (idx >= 0 && !service_active_or_running(&ServiceTable[idx])) {
            free(copy);
            return false;
        }
        token = strtok_r(NULL, ",", &saveptr);
    }
    free(copy);
    return true;
}

static bool service_before_blocked(ServiceIndex *si) {
    if (!si || !si->before) return false;

    char *copy = strdup(si->before);
    if (!copy) return false;
    char *saveptr = NULL;
    char *token = strtok_r(copy, ",", &saveptr);
    while (token) {
        char *dep = token;
        while (*dep && isspace((unsigned char)*dep)) dep++;
        char *end = dep + strlen(dep) - 1;
        while (end >= dep && isspace((unsigned char)*end)) *end-- = '\0';
        int idx = service_index_by_name(dep);
        if (idx >= 0 && !service_active_or_running(&ServiceTable[idx])) {
            free(copy);
            return true;
        }
        token = strtok_r(NULL, ",", &saveptr);
    }
    free(copy);
    return false;
}

static bool can_start_service(ServiceIndex *si, const char *target_name) {
    if (!si || si->state != SERVICE_STATE_INACTIVE) return false;
    if (!service_matches_target(si, target_name)) return false;
    if (!service_requires_satisfied(si)) return false;
    if (!service_after_satisfied(si)) return false;
    if (service_before_blocked(si)) return false;
    return true;
}

static void stop_non_target_services(const char *target_name) {
    for (size_t i = 0; i < ServiceTableCount; i++) {
        ServiceIndex *si = &ServiceTable[i];
        if (si->pid > 0 && !service_matches_target(si, target_name)) {
            StopService(si->serviceid);
            si->state = SERVICE_STATE_STOPPED;
            printf("[ INFO ] Stopped service outside isolated target: %s\n", si->name);
        }
    }
}

static void start_services_for_target(const char *target_name) {
    bool progress = true;
    size_t max_passes = ServiceTableCount + 1;
    size_t pass = 0;

    while (progress && pass < max_passes) {
        progress = false;
        for (size_t i = 0; i < ServiceTableCount; i++) {
            ServiceIndex *si = &ServiceTable[i];
            if (!can_start_service(si, target_name)) continue;

            si->state = SERVICE_STATE_STARTING;
            if (StartService(si) != -1) {
                si->state = SERVICE_STATE_RUNNING;
                progress = true;
            } else {
                si->state = SERVICE_STATE_FAILED;
            }
        }
        pass++;
    }
}

void _start_service_early(void)
{
    printf("[ INFO ] Starting early services...\n");

    const char *service_dir_path = "/etc/minitd/services";
    DIR *dir = opendir(service_dir_path);
    if (!dir) {
        perror("[ FAIL ] Could not open /etc/minitd/services");
        return;
    }

    struct dirent *entry;
    while ((entry = readdir(dir)) != NULL) {
        if (strcmp(entry->d_name, ".") == 0 || strcmp(entry->d_name, "..") == 0) {
            continue;
        }

        size_t name_len = strlen(entry->d_name);
        if (name_len < 4 || strcmp(entry->d_name + name_len - 4, ".svc") != 0) {
            continue;
        }

        char full_path[512];
        snprintf(full_path, sizeof(full_path), "%s/%s", service_dir_path, entry->d_name);

        /* Open config using milang */
        MiConfig *cfg = open_config(full_path);
        if (!cfg) continue;

        /* Check IGNORE flag */
        char *ignore_val = readkey(cfg, "IGNORE");
        if (ignore_val) {
            int should_ignore = atoi(ignore_val);
            free(ignore_val);
            if (should_ignore == 1) {
                printf("[ INFO ] Skipping ignored service: %s\n", entry->d_name);
                close_config(cfg);
                continue;
            }
        }

        /* Read Service Attributes */
        char *svc_name = readkey(cfg, "Name");
        char *exec_path = readkey(cfg, "Exec"); // or Path / Executable path
        char *policy_str = readkey(cfg, "Policy"); // e.g. "always" or "once"
        char *run_target = readkey(cfg, "RunOnTarget");
        char *state_target = readkey(cfg, "StateTarget");
        char *wants = readkey(cfg, "Wants");
        char *requires = readkey(cfg, "Requires");
        char *after = readkey(cfg, "After");
        char *before = readkey(cfg, "Before");
        char *type_str = readkey(cfg, "Type");
        char *restart_str = readkey(cfg, "Restart");

        if (svc_name && exec_path) {
            ServicePolicy policy = SERVICE_ONCE;
            if (policy_str && strcmp(policy_str, "always") == 0) {
                policy = SERVICE_ALWAYS;
            }

            ServiceUnitType unit_type = SERVICE_TYPE_SIMPLE;
            if (type_str) {
                if (strcmp(type_str, "oneshot") == 0) unit_type = SERVICE_TYPE_ONESHOT;
                else if (strcmp(type_str, "forking") == 0) unit_type = SERVICE_TYPE_FORKING;
                else if (strcmp(type_str, "notify") == 0) unit_type = SERVICE_TYPE_NOTIFY;
            }

            RestartPolicy restart = RESTART_NO;
            if (restart_str) {
                if (strcmp(restart_str, "always") == 0) restart = RESTART_ALWAYS;
                else if (strcmp(restart_str, "on-failure") == 0) restart = RESTART_ON_FAILURE;
            }

            /* 1. Create and Register Service (store target selectors and dependencies) */
            ServiceIndex si = CreateService(policy, exec_path, svc_name, run_target, state_target, wants, requires, after, before, unit_type, restart);
            if (RegisterService(&si)) {
                ;
            }
        } else {
            printf("[ WARN ] Invalid service file (missing Name or Exec): %s\n", entry->d_name);
        }

        /* Clean up allocations */
        if (svc_name) free(svc_name);
        if (exec_path) free(exec_path);
        if (policy_str) free(policy_str);
        if (run_target) free(run_target);
        if (state_target) free(state_target);
        if (wants) free(wants);
        if (requires) free(requires);
        if (after) free(after);
        if (before) free(before);
        if (type_str) free(type_str);
        if (restart_str) free(restart_str);

        close_config(cfg);
    }

    closedir(dir);
    printf("[ OK ] Finished registering services\n");

    /* Load targets and start services according to target order */
    const char *target_dir = "/etc/minitd/targetfiles";
    DIR *tdir = opendir(target_dir);
    if (!tdir) {
        perror("[ FAIL ] Could not open /etc/minitd/targetfiles");
        return;
    }

    /* Simple target struct */
    typedef struct {
        char *filename; /* e.g. basic.target */
        char *name;
        char *next;    /* next target filename */
        int level;
        bool isolate;
    } TargetEntry;

    TargetEntry *targets = NULL;
    size_t targets_count = 0;
    size_t targets_cap = 0;

    while ((entry = readdir(tdir)) != NULL) {
        if (strcmp(entry->d_name, ".") == 0 || strcmp(entry->d_name, "..") == 0) continue;
        size_t name_len = strlen(entry->d_name);
        if (name_len < 7 || strcmp(entry->d_name + name_len - 7, ".target") != 0) continue;

        char full_path[512];
        snprintf(full_path, sizeof(full_path), "%s/%s", target_dir, entry->d_name);
        MiConfig *tcfg = open_config(full_path);
        if (!tcfg) continue;

        char *tname = readkey(tcfg, "Name");
        char *tnext = readkey(tcfg, "Next");
        char *tlevel = readkey(tcfg, "Level");
        char *tisolate = readkey(tcfg, "Isolate");
        char *ignore = readkey(tcfg, "IGNORE");
        if (ignore) {
            int should_ignore = atoi(ignore);
            free(ignore);
            if (should_ignore == 1) {
                printf("[ INFO ] Skipping ignored target: %s\n", entry->d_name);
                if (tname) free(tname);
                if (tnext) free(tnext);
                if (tlevel) free(tlevel);
                if (tisolate) free(tisolate);
                close_config(tcfg);
                continue;
            }
        }

        if (targets_count >= targets_cap) {
            size_t newcap = (targets_cap == 0) ? 4 : targets_cap * 2;
            TargetEntry *nt = realloc(targets, newcap * sizeof(TargetEntry));
            if (!nt) {
                close_config(tcfg);
                break;
            }
            targets = nt;
            targets_cap = newcap;
        }

        targets[targets_count].filename = strdup(entry->d_name);
        targets[targets_count].name = tname ? tname : NULL;
        targets[targets_count].next = (tnext && *tnext) ? tnext : NULL;
        targets[targets_count].level = tlevel ? atoi(tlevel) : 0;
        targets[targets_count].isolate = (tisolate && atoi(tisolate) != 0);
        targets_count++;

        if (tlevel) free(tlevel);
        if (tisolate) free(tisolate);
        if (!targets[targets_count-1].next && tnext) free(tnext);
        close_config(tcfg);
    }

    closedir(tdir);

    char *max_opt = NULL;
    int max_level = 0;
    int max_ignore = 0;
    FILE *max_fp = fopen("/etc/minitd/targetfiles/maxtarg.conf", "r");
    if (max_fp) {
        fclose(max_fp);
        MiConfig *maxcfg = open_config("/etc/minitd/targetfiles/maxtarg.conf");
        if (maxcfg) {
            char *value = readkey(maxcfg, "LEVEL");
            if (value) {
                max_level = atoi(value);
                free(value);
            }
            value = readkey(maxcfg, "OptFile");
            if (value) {
                max_opt = value;
            }
            value = readkey(maxcfg, "IGNORE");
            if (value) {
                max_ignore = atoi(value);
                free(value);
            }
            close_config(maxcfg);
        }
    }

    if (max_ignore == 1) {
        printf("[ INFO ] maxtarg.conf is ignored via IGNORE=1\n");
        max_level = 0;
        if (max_opt) {
            free(max_opt);
            max_opt = NULL;
        }
    }

    if (targets_count == 0) {
        printf("[ INFO ] No targets defined; starting all registered services\n");
        for (size_t i = 0; i < ServiceTableCount; i++) {
            if (StartService(&ServiceTable[i]) != -1) {
                printf("[ OK ] Started service: %s\n", ServiceTable[i].name);
            }
        }
        if (max_opt) free(max_opt);
        return;
    }

    /* Find starting target: prefer OptFile when available, otherwise basic.target, otherwise lowest allowed level */
    int start_index = -1;
    if (max_opt) {
        for (size_t i = 0; i < targets_count; i++) {
            if (strcmp(targets[i].filename, max_opt) == 0 || (targets[i].name && strcmp(targets[i].name, max_opt) == 0)) {
                if (max_level > 0 && targets[i].level > max_level) {
                    printf("[ WARN ] Requested OptFile target '%s' is above max level %d; ignoring OptFile\n", max_opt, max_level);
                } else {
                    start_index = (int)i;
                }
                break;
            }
        }
        if (start_index == -1) {
            printf("[ INFO ] OptFile target '%s' not found or not eligible; falling back to default target selection\n", max_opt);
        }
    }

    if (start_index == -1) {
        for (size_t i = 0; i < targets_count; i++) {
            if (strcmp(targets[i].filename, "basic.target") == 0) {
                if (max_level == 0 || targets[i].level <= max_level) {
                    start_index = (int)i;
                    break;
                }
            }
        }
    }

    if (start_index == -1) {
        int lowest = INT32_MAX;
        for (size_t i = 0; i < targets_count; i++) {
            if (max_level > 0 && targets[i].level > max_level) continue;
            if (targets[i].level < lowest) {
                lowest = targets[i].level;
                start_index = (int)i;
            }
        }
        if (start_index == -1) {
            start_index = 0;
        }
    }

    /* Process target chain */
    char *current = strdup(targets[start_index].filename);
    while (current) {
        printf("[ INFO ] Activating target: %s\n", current);

        int target_index = -1;
        for (size_t i = 0; i < targets_count; i++) {
            if (strcmp(targets[i].filename, current) == 0) {
                target_index = (int)i;
                break;
            }
        }

        if (target_index >= 0 && max_level > 0 && targets[target_index].level > max_level) {
            printf("[ INFO ] Target %s is above max level %d; stopping target chain\n", current, max_level);
            free(current);
            break;
        }

        if (target_index >= 0 && targets[target_index].isolate) {
            stop_non_target_services(current);
        }

        start_services_for_target(current);

        /* Find next */
        char *next_target = NULL;
        if (target_index >= 0 && targets[target_index].next) {
            /* If next target exists but is above max level, stop the chain. */
            int next_index = -1;
            for (size_t i = 0; i < targets_count; i++) {
                if (strcmp(targets[i].filename, targets[target_index].next) == 0) {
                    next_index = (int)i;
                    break;
                }
            }
            if (next_index >= 0 && max_level > 0 && targets[next_index].level > max_level) {
                printf("[ INFO ] Next target %s is above max level %d; ending chain\n", targets[target_index].next, max_level);
            } else {
                next_target = strdup(targets[target_index].next);
            }
        }

        free(current);
        current = next_target;
    }

    if (max_opt) free(max_opt);

    /* free target entries */
    for (size_t i = 0; i < targets_count; i++) {
        if (targets[i].filename) free(targets[i].filename);
        if (targets[i].name) free(targets[i].name);
        if (targets[i].next) free(targets[i].next);
    }
    free(targets);
}
