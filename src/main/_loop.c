#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <signal.h>
#include <sys/wait.h>
#include <sys/reboot.h>
#include <minit/api.h>

static void sigchld_handler(int sig) {
    (void)sig;
}

void __m_loop(pid_t primary_child) {
    struct sigaction sa;
    sa.sa_handler = sigchld_handler;
    sigemptyset(&sa.sa_mask);
    sa.sa_flags = SA_NOCLDSTOP; 
    sigaction(SIGCHLD, &sa, NULL);

    while (1) {
        int status;
        pid_t reaped;
        while ((reaped = waitpid(-1, &status, WNOHANG)) > 0) {
            printf("[ OK ] Reaped zombie PID %d\n", reaped);

            if (reaped == primary_child) {
                printf("[ OK ] Primary process exited. Shutting down...\n");
                return;
            }
        }

        if (reaped == -1 && errno == ECHILD) {
            // No children left at all
            break;
        }

        pause();
    }
}