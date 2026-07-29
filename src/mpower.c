#include <stdio.h>
#include <unistd.h>
#include <signal.h>
#include <errno.h>
#include <string.h>
#include <sys/reboot.h>
#include <sys/mount.h>
#include <minit/api.h>

void mshutdown(int cmd) {
    printf("\n[ INFO ] Terminating remaining user processes...\n");

    signal(SIGTERM, SIG_IGN);
    signal(SIGKILL, SIG_IGN);

    kill(-1, SIGTERM);
    usleep(100000);
    kill(-1, SIGKILL);

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

    reboot(cmd);
}

void mpower_off(void) {
    mshutdown(RB_POWER_OFF);
}

void mreboot(void) {
    mshutdown(RB_AUTOBOOT);
}