#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <minit/api.h>

void mpanic(const char* reason)
{
    fprintf(stderr, "\n[ FATAL ] %s\n", reason ? reason : "Unknown error");
    fflush(stderr);
    if(g_Book && g_Book->inited) {
        BookWriteLog(g_Book, reason ? reason : "Unknown error", LOG_LEVEL_CRITICAL);
    }
    exit(1);
}

void mfreeze(void)
{
    fprintf(stderr, "\n[ FATAL ] System freeze requested. Halting.\n");
    fflush(stderr);
    if(g_Book && g_Book->inited) {
        BookWriteLog(g_Book, "System freeze requested", LOG_LEVEL_CRITICAL);
    }

    while (1) {
        pause();
    }
}

void mupdate(void)
{
    printf("[ INFO ] System update requested. Rebooting...\n");
    fflush(stdout);

    if(g_Book && g_Book->inited) {
        BookWriteLog(g_Book, "System update requested", LOG_LEVEL_INFO);
    }

    /* Use low-level open/write or flush/sync to ensure the flag hits disk */
    FILE *fp = fopen("/etc/minitd/update.1", "w");
    if (fp) {
        fprintf(fp, "UPDATE=1\n");
        fflush(fp);
        fsync(fileno(fp));
        fclose(fp);
    } else {
        perror("[ FAIL ] Could not create /etc/minitd/update.1");
    }

    sync();
    mreboot();
    
}