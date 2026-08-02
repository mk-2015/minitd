#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <time.h>
#include <stdbool.h>
#include <string.h>
#include <sys/wait.h>
#include <sys/ioctl.h>
#include <pthread.h>

#include <minit/api.h>
#include <minit/process.h>
#include <libubookd/booker.h>

extern int __post_success(void);
extern Book* g_Book;

pthread_t tid;

extern struct timespec start, end;

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
        if (g_Book && g_Book->inited) {
            int log_fd = fileno(g_Book->fp);
            if (log_fd >= 0) {
                dup2(log_fd, STDOUT_FILENO);
                dup2(log_fd, STDERR_FILENO);
            }
        } else {
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
}

volatile sig_atomic_t g_shutdown_requested = 0;
volatile sig_atomic_t g_reboot_requested = 0;

void __power(void) {
    while (1) {
        if (g_shutdown_requested) {
            redirect_init_logs(IDP_CONSOLE_DIRECT);
            fprintf(stderr, "[ INFO ] Shutdown requested\n");
            BookWriteLog(g_Book, "Shutdown requested", LOG_LEVEL_INFO);
            mpower_off();
        } else if (g_reboot_requested) {
            redirect_init_logs(IDP_CONSOLE_DIRECT);
            fprintf(stderr, "[ INFO ] Reboot requested\n");
            BookWriteLog(g_Book, "Reboot requested", LOG_LEVEL_INFO);
            mreboot();
        }
        sleep(1);
    }
}

void __m_loop(void) {
    redirect_init_logs(IDP_CONSOLE_LOGFIL);
    sigset_t wait_mask;
    sigemptyset(&wait_mask);

    if (__post_success() != 0) {
        redirect_init_logs(IDP_CONSOLE_DIRECT);
        fprintf(stderr, "[ FAIL ] Failed to run post-success initialization\n");
        BookWriteLog(g_Book, "Failed to run post-success initialization", LOG_LEVEL_CRITICAL);
        mpanic("Post-success initialization failed");
    }

    if(pthread_create(&tid, NULL, (void*(*)(void*))__power, NULL) != 0) {
        redirect_init_logs(IDP_CONSOLE_DIRECT);
        fprintf(stderr, "[ FAIL ] Failed to create power thread\n");
        BookWriteLog(g_Book, "Failed to create power thread", LOG_LEVEL_CRITICAL);
        mpanic("Main power thread creation failed");
    }

    redirect_init_logs(IDP_CONSOLE_DIRECT);
    clock_gettime(CLOCK_MONOTONIC, &end);

    long seconds = end.tv_sec - start.tv_sec;
    long nanoseconds = end.tv_nsec - start.tv_nsec;

    if (nanoseconds < 0) {
        seconds -= 1;
        nanoseconds += 1000000000L;
    }

    long total_ms = seconds * 1000 + nanoseconds / 1000000L;

    long mm = total_ms / 60000;
    long ss = (total_ms % 60000) / 1000;
    long msms = total_ms % 1000;

    printf("[ INFO ] minitd started in: %02ldm %02lds %03ldms\n", mm, ss, msms);
    redirect_init_logs(IDP_CONSOLE_LOGFIL);

    while (1) {
        sigsuspend(&wait_mask);
    }

    // never reach here, but if we do, ensure logs are redirected and handle shutdown/reboot
    redirect_init_logs(IDP_CONSOLE_DIRECT);
    if (g_reboot_requested) {
        BookWriteLog(g_Book, "Reboot requested", LOG_LEVEL_INFO);
        mreboot();
    } else {
        BookWriteLog(g_Book, "Shutdown requested", LOG_LEVEL_INFO);
        mpower_off();
    }
}