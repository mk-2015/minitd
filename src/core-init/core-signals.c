#include <stdio.h>
#include <signal.h>
#include <stdbool.h>
#include <sys/types.h>
#include <sys/wait.h>

#include <minit/api.h>

extern volatile sig_atomic_t g_shutdown_requested;
extern volatile sig_atomic_t g_reboot_requested;

static void sigchld_handler(int sig) {
    (void)sig;
    int status;
    pid_t pid;

    while ((pid = waitpid(-1, &status, WNOHANG)) > 0) {
        printf("[ REAPER ] Reaped process PID %d\n", pid);
    }
}

static void sigterm_handler(int sig) {
    printf("[ INIT ] Received signal %d (%s) - initiating poweroff sequence...\n", 
           sig, sig == SIGTERM ? "SIGTERM" : "SIGPWR");
    g_shutdown_requested = 1;
}

static void sigint_handler(int sig) {   
    (void)sig;
    printf("[ INIT ] Received SIGINT - initiating system reboot...\n");
    g_reboot_requested = 1;
}

static void sighup_handler(int sig) {
    (void)sig;
    printf("[ INIT ] Received SIGHUP - reloading state...\n");
}

void _sign_early(void) {
    struct sigaction sa;

    sa.sa_handler = sigchld_handler;
    sigemptyset(&sa.sa_mask);
    sa.sa_flags = SA_NOCLDSTOP | SA_RESTART;

    if (sigaction(SIGCHLD, &sa, NULL) < 0) {
        printf("[ FAIL ] Failed to register SIGCHLD handler\n");
        mpanic("Failed to initialize SIGCHLD signal handler!");
    }

    sa.sa_handler = sigterm_handler;
    sigemptyset(&sa.sa_mask);
    sa.sa_flags = SA_RESTART;

    if (sigaction(SIGTERM, &sa, NULL) < 0) {
        printf("[ FAIL ] Failed to register SIGTERM handler\n");
        mpanic("Failed to initialize SIGTERM signal handler!");
    }

    if (sigaction(SIGPWR, &sa, NULL) < 0) {
        printf("[ FAIL ] Failed to register SIGPWR handler\n");
        mpanic("Failed to initialize SIGPWR signal handler!");
    }

    sa.sa_handler = sigint_handler;
    sigemptyset(&sa.sa_mask);
    sa.sa_flags = SA_RESTART;

    if (sigaction(SIGINT, &sa, NULL) < 0) {
        printf("[ FAIL ] Failed to register SIGINT handler\n");
        mpanic("Failed to initialize SIGINT signal handler!");
    }

    sa.sa_handler = sighup_handler;
    sigemptyset(&sa.sa_mask);
    sa.sa_flags = SA_RESTART;

    if (sigaction(SIGHUP, &sa, NULL) < 0) {
        printf("[ FAIL ] Failed to register SIGHUP handler\n");
        mpanic("Failed to initialize SIGHUP signal handler!");
    }

    printf("[ OK ] Early signal handling initialized successfully.\n");
}