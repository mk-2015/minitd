#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <errno.h>
#include <pthread.h>

#include <minit/api.h>
#include <minit/process.h>
#include <libubookd/booker.h>

Book* g_Book = NULL;
static pthread_t g_kmsg_thread;
static volatile int g_kmsg_running = 0;

void* kmsg_logger_thread(void *arg) {
    const char *log_path = (const char *)arg;

    int kmsg_fd = open("/dev/kmsg", O_RDONLY | O_NONBLOCK);
    if (kmsg_fd < 0) {
        perror("[ FAIL ] kmsg_logger_thread: Failed to open /dev/kmsg");
        pthread_exit(NULL);
    }

    int log_fd = open(log_path, O_WRONLY | O_CREAT | O_APPEND, 0644);
    if (log_fd < 0) {
        perror("[ FAIL ] kmsg_logger_thread: Failed to open log file");
        close(kmsg_fd);
        pthread_exit(NULL);
    }

    lseek(kmsg_fd, 0, SEEK_SET);

    char buffer[4096];
    ssize_t bytes_read;

    g_kmsg_running = 1;

    while (g_kmsg_running) {
        bytes_read = read(kmsg_fd, buffer, sizeof(buffer));

        if (bytes_read > 0) {
            write(log_fd, buffer, bytes_read);
        } else if (bytes_read < 0) {
            if (errno == EAGAIN || errno == EWOULDBLOCK) {
                usleep(100000); 
            } else if (errno == EPIPE) {
                continue;
            } else {
                break;
            }
        }
    }

    close(log_fd);
    close(kmsg_fd);
    pthread_exit(NULL);
}

int _early_core_bookd(const char* params) {
    if (!params) return -1;

    g_Book = (Book*)malloc(sizeof(Book));
    if (!g_Book) return -1;

    int ret = OpenBook((char*)params, BOOK_FILE_PERM, g_Book);
    if (ret != 0) {
        free(g_Book);
        g_Book = NULL;
        return -1;
    }

    pthread_attr_t attr;
    pthread_attr_init(&attr);
    pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);

    const char *kmsg_log_target = "/var/log/minitd.log";
    if (pthread_create(&g_kmsg_thread, &attr, kmsg_logger_thread, (void*)kmsg_log_target) != 0) {
        perror("[ WARN ] Failed to spawn kmsg logger thread");
    }

    pthread_attr_destroy(&attr);

    printf("[ INFO ] Early-core bookd started with log file\n");

    return 0;
}