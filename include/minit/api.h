#ifndef __MINITD_API_H__
#define __MINITD_API_H__

#include <sys/types.h>
#include <string.h>

// Define missing mount flags if not present in system headers
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

extern const MountPoint mount_table[];
extern const size_t mount_table_size;

extern const EnvironVar environ_default_table[];
extern const size_t environ_default_table_size;

void mpanic(const char* reason);

void mpower_off(void);
void mreboot(void);
void mshutdown(int cmd);    

#endif