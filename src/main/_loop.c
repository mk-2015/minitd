#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <signal.h>
#include <sys/wait.h>
#include <sys/reboot.h>
#include <sys/types.h>
#include <minit/api.h>

volatile sig_atomic_t g_shutdown_requested = 0;
volatile sig_atomic_t g_reboot_requested = 0;

void __m_loop(pid_t primary_child) {
    sigset_t empty_mask;
    sigemptyset(&empty_mask);

    while (!g_shutdown_requested && !g_reboot_requested) {
        sigsuspend(&(sigset_t){0});

        if (primary_child > 0 && kill(primary_child, 0) == -1 && errno == ESRCH) {
            printf("[ INIT ] Primary shell (PID %d) exited.\n", primary_child);
            g_shutdown_requested = 1;
        }
    }

    if (g_reboot_requested) {
        printf("[ INIT ] Reboot requested. Executing reboot sequence...\n");
        mreboot();
    } else if (g_shutdown_requested) {
        printf("[ INIT ] Shutdown requested or shell exited. Powering off...\n");
        mpower_off();
    } else {
        mpanic("Somehow killed PID 1 [MINITD]");
    }
}