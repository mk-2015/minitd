#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <stdbool.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mount.h>
#include <sys/wait.h>

// internal
#include <minit/api.h>

extern void __m_loop(pid_t primary_child);
extern void _early_core(const char* params);

// Definition of the mount table
const MountPoint mount_table[] = {
    {
        .what = "devtmpfs",
        .where = "/dev",
        .type = "devtmpfs",
        .options = "mode=0755",
        .flags = MS_NOSUID | MS_STRICTATIME,
        .mode = MNT_FATAL | MNT_CREATE
    },
    {
        .what = "proc",
        .where = "/proc",
        .type = "proc",
        .options = NULL,
        .flags = MS_NOSUID | MS_NOEXEC | MS_NODEV,
        .mode = MNT_FATAL | MNT_CREATE
    },
    {
        .what = "sysfs",
        .where = "/sys",
        .type = "sysfs",
        .options = NULL,
        .flags = MS_NOSUID | MS_NOEXEC | MS_NODEV,
        .mode = MNT_FATAL | MNT_CREATE
    },
    {
        .what = "securityfs",
        .where = "/sys/kernel/security",
        .type = "securityfs",
        .options = NULL,
        .flags = MS_NOSUID | MS_NOEXEC | MS_NODEV,
        .mode = MNT_CREATE
    },
    {
        .what = "tmpfs",
        .where = "/run",
        .type = "tmpfs",
        .options = "mode=0755",
        .flags = MS_NOSUID | MS_NODEV | MS_STRICTATIME,
        .mode = MNT_FATAL | MNT_CREATE
    },
    {
        .what = "tmpfs",
        .where = "/tmp",
        .type = "tmpfs",
        .options = "mode=1777",
        .flags = MS_NOSUID | MS_NODEV | MS_STRICTATIME,
        .mode = MNT_FATAL | MNT_CREATE
    },
    {
        .what = "devpts",
        .where = "/dev/pts",
        .type = "devpts",
        .options = "mode=0620,ptmxmode=0666",
        .flags = MS_NOSUID | MS_NOEXEC,
        .mode = MNT_CREATE
    },
    {
        .what = "cgroup2",
        .where = "/sys/fs/cgroup",
        .type = "cgroup2",
        .options = "nsdelegate",
        .flags = MS_NOSUID | MS_NOEXEC | MS_NODEV,
        .mode = MNT_CREATE
    }
};

const size_t mount_table_size = sizeof(mount_table) / sizeof(mount_table[0]);

// Helper function to create nested directories safely (like mkdir -p)
static void mkdir_p(const char *path, mode_t mode) {
    char tmp[256];
    char *p = NULL;

    snprintf(tmp, sizeof(tmp), "%s", path);
    size_t len = strlen(tmp);
    if (len > 0 && tmp[len - 1] == '/') {
        tmp[len - 1] = 0;
    }
    for (p = tmp + 1; *p; p++) {
        if (*p == '/') {
            *p = 0;
            mkdir(tmp, mode);
            *p = '/';
        }
    }
    mkdir(tmp, mode);
}

// Iterator function to mount everything in table
static void mount_setup(void) {
    for (size_t i = 0; i < mount_table_size; i++) {
        const MountPoint *mp = &mount_table[i];

        if (mp->mode & MNT_CREATE) {
            mkdir_p(mp->where, 0755);
        }

        int res = mount(mp->what, mp->where, mp->type, mp->flags, mp->options);

        if (res == 0) {
            printf("[ OK ] Mounted %s -> %s\n", mp->what, mp->where);
        } else {
            if (errno == EBUSY) {
                printf("[ INFO ] %s already mounted.\n", mp->where);
            } else {
                printf("[ FAIL ] Failed to mount %s on %s: %s\n", 
                       mp->what, mp->where, strerror(errno));
                if (mp->mode & MNT_FATAL) {
                    mpanic("Required virtual filesystem mount failed!");
                }
            }
        }
    }
}

int main(int argc, char *argv[]) {
    if (getpid() != 1) {
        fprintf(stderr, "Error: Must run as PID 1.\n");
        return 1;
    }

    // 1. Set up mounts
    mount_setup();

    // 2. Redirect stdin/stdout/stderr to /dev/console
    int fd = open("/dev/console", O_RDWR);
    if (fd >= 0) {
        dup2(fd, STDIN_FILENO);
        dup2(fd, STDOUT_FILENO);
        dup2(fd, STDERR_FILENO);
        if (fd > STDERR_FILENO) close(fd);

        setsid();
        ioctl(STDIN_FILENO, TIOCSCTTY, 1);
    }

    _early_core("");

    printf("[ OK ] minitd started successfully!\n\n");

    // 3. Launch interactive shell
    pid_t pidpri = fork();
    if (pidpri == 0) {
        printf("[ SH ] Launching shell...\n");
        char *shell_args[] = { "/bin/sh", NULL };
        execv(shell_args[0], shell_args);

        perror("[ SH ] Failed to start shell");
        _exit(1);
    }

    // 4. Signal / Process Reaping Loop
    __m_loop(pidpri);

    mpower_off();
}