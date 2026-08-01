#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdbool.h>
#include <string.h>
#include <sys/wait.h>
#include <sys/ioctl.h>

#include <minit/api.h>
#include <minit/process.h>

extern int __post_success(void);

void redirect_init_logs(int idp) {
    if (idp == IDP_CONSOLE_DIRECT) {
        int fd = open("/dev/console", O_RDWR);
        if (fd >= 0) {
            dup2(fd, STDIN_FILENO);
            dup2(fd, STDOUT_FILENO);
            dup2(fd, STDERR_FILENO);
            if (fd > STDERR_FILENO) close(fd);

            setsid();
            ioctl(STDIN_FILENO, TIOCSCTTY, 1);
        }
    } else if (idp == IDP_CONSOLE_LOGFIL) {
        int log_fd = open("/run/minitd.log", O_WRONLY | O_CREAT | O_TRUNC | O_CLOEXEC, 0644);
        if (log_fd < 0) {
            log_fd = open("/dev/null", O_WRONLY);
        }

        if (log_fd >= 0) {
            dup2(log_fd, STDOUT_FILENO);
            dup2(log_fd, STDERR_FILENO);
            if (log_fd > STDERR_FILENO) {
                close(log_fd);
            }
        }
    }
}

volatile sig_atomic_t g_shutdown_requested = 0;
volatile sig_atomic_t g_reboot_requested = 0;

void __m_loop(void) {
    redirect_init_logs(IDP_CONSOLE_LOGFIL);
    sigset_t wait_mask;
    sigemptyset(&wait_mask);

    if (__post_success() != 0) {
        redirect_init_logs(IDP_CONSOLE_DIRECT);
        fprintf(stderr, "[ FAIL ] Failed to run post-success initialization\n");
        mpanic("Post-success initialization failed");
    }

    while (1) {
        if (g_reboot_requested || g_shutdown_requested) {
            break;
        }

        sigsuspend(&wait_mask);

        if (g_reboot_requested || g_shutdown_requested) {
            break;
        }
    }

    redirect_init_logs(IDP_CONSOLE_DIRECT);
    if (g_reboot_requested) {
        mreboot();
    } else {
        mpower_off();
    }
}