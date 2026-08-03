#ifndef __MINITD_API_H__
#define __MINITD_API_H__

#include <sys/types.h>
#include <string.h>
#include <stdarg.h>

#ifndef MS_NOSUID
#define MS_NOSUID 2
#endif
#ifndef MS_NODEV
#define MS_NODEV 4
#endif
#ifndef MS_NOEXEC
#define MS_NOEXEC 8
#endif
#ifndef MS_STRICTATIME
#define MS_STRICTATIME 16777216
#endif

#define MVER "1.0.0"
#define MAX_CHARS_HOSTNAME 255
#define MAX_CHARS_ENVNAME 255
#define MAX_CHARS_ENVCONTENT 4096

#define IDP_CONSOLE_DIRECT 1
#define IDP_CONSOLE_LOGFIL 2

typedef enum MountMode {
    MNT_NONE     = 0,
    MNT_FATAL    = 1 << 0, // Panic or stop if mounting fails
    MNT_CREATE   = 1 << 1  // Auto-create directory before mounting
} MountMode;

typedef struct {
    const char *what;    // Source (e.g., "proc", "sysfs", "tmpfs")
    const char *where;   // Mount point target (e.g., "/proc")
    const char *type;    // Filesystem type
    const char *options; // Mount options string (e.g., "mode=0755")
    unsigned long flags; // Mount flags (MS_NOSUID, MS_NODEV, etc.)
    MountMode mode;      // Behavior flags
} MountPoint;

typedef struct {
    char name[MAX_CHARS_ENVNAME];
    char content[MAX_CHARS_ENVCONTENT];
} EnvironVar;

typedef enum {
    MINIT_STATE_RUNNING,
    MINIT_STATE_SHUTDOWN,
    MINIT_STATE_REBOOT
} MinitSystemState;

typedef enum {
    JOB_TYPE_START,
    JOB_TYPE_STOP
} JobType;

typedef struct {
    char *name;
    JobType type;
    char *target;
    int level;
    char *exec;
} MinitJob;

extern volatile MinitSystemState g_system_state;

extern const MountPoint mount_table[];
extern const size_t mount_table_size;

extern const EnvironVar environ_default_table[];
extern const size_t environ_default_table_size;

void mpanic(const char* reason, ...);
void mvpanic(const char *reason, va_list args);
void mfreeze(void);
void mupdate(void);

void mpower_off(void);
void mreboot(void);
void mshutdown(int cmd);    

void redirect_init_logs(int idp);


typedef struct Target {
    const char* name;
    unsigned int Level;
} Target;

void run_jobs_for_target(const char *target_name, int target_level, JobType type);
#endif