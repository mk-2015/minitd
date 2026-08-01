#include <stdio.h>
#include <unistd.h>
#include <signal.h>
#include <errno.h>
#include <string.h>
#include <sys/reboot.h>
#include <sys/mount.h>
#include <minit/api.h>
#include <minit/process.h>
#include <minit/service.h>

extern const MountPoint mount_table[];
extern const size_t mount_table_size;
volatile MinitSystemState g_system_state = MINIT_STATE_RUNNING;

void mshutdown(int cmd) {
    /* 1. Redirect logs to physical console and unbuffer stdout */
    redirect_init_logs(IDP_CONSOLE_DIRECT);
    setvbuf(stdout, NULL, _IONBF, 0);

    if (cmd == RB_AUTOBOOT) {
        g_system_state = MINIT_STATE_REBOOT;
    } else {
        g_system_state = MINIT_STATE_SHUTDOWN;
    }

    printf("\n[ INFO ] Terminating managed services...\n");

    signal(SIGTERM, SIG_IGN);
    signal(SIGINT,  SIG_IGN);
    signal(SIGHUP,  SIG_IGN);

    StopAllServices();

    printf("[ INFO ] Terminating remaining user processes...\n");

    signal(SIGCHLD, SIG_IGN);

    kill(-1, SIGTERM);
    usleep(200000);

    kill(-1, SIGKILL);
    usleep(50000);

    printf("[ OK ] Syncing disk buffers...\n");
    sync();

    printf("[ INFO ] Unmounting virtual filesystems...\n");
    for (ssize_t i = (ssize_t)mount_table_size - 1; i >= 0; i--) {
        const MountPoint *mp = &mount_table[i];

        if (umount(mp->where) == 0) {
            printf("[ OK ] Unmounted %s\n", mp->where);
        } else {
            if (umount2(mp->where, MNT_DETACH) == 0) {
                printf("[ INFO ] Detached busy mount %s\n", mp->where);
            } else {
                printf("[ FAIL ] Failed to unmount %s: %s\n", mp->where, strerror(errno));
            }
        }
    }

    if (cmd == RB_POWER_OFF) {
        printf("[ OK ] Powering off system.\n");
    } else if (cmd == RB_AUTOBOOT) {
        printf("[ OK ] Rebooting system.\n");
    }

    sync();
    reboot(cmd);

    while (1) pause();
}

void mpower_off(void) {
    mshutdown(RB_POWER_OFF);
}

void mreboot(void) {
    mshutdown(RB_AUTOBOOT);
}