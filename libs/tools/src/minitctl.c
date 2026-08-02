#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <poll.h>
#include <libunotifi/unotifi.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <errno.h>

#define BUF_SIZE 4096
#define SOCKET_PATH "/run/minitd/contrl.sock"

int main(int argc, char **argv) {
    int fd = openCommunicationChannel(SOCKET_PATH);
    if (fd < 0) {
        fprintf(stderr, "Failed to connect to minitd (%s): %s\n", SOCKET_PATH, strerror(errno));
        return 1;
    }

    if (unotifi_send_handshake(fd, getpid(), "minitctl") != UNOTIFI_OK) {
        fprintf(stderr, "Failed to send handshake\n");
        close(fd);
        return 1;
    }

    char *handshake_info = NULL;
    unotifi_recv_handshake(fd, &handshake_info);
    if (handshake_info) free(handshake_info);

    /* ONE-SHOT MODE */
    if (argc > 1) {
        char cmd[BUF_SIZE] = {0};
        for (int i = 1; i < argc; i++) {
            strncat(cmd, argv[i], sizeof(cmd) - strlen(cmd) - 1);
            if (i < argc - 1) strncat(cmd, " ", sizeof(cmd) - strlen(cmd) - 1);
        }

        if (unotifi_send_data(fd, cmd) != UNOTIFI_OK) {
            fprintf(stderr, "Failed to send command\n");
            close(fd);
            return 1;
        }

        char *resp = NULL;
        if (unotifi_recv_data(fd, &resp) == UNOTIFI_OK && resp) {
            printf("%s\n", resp);
            free(resp);
        }

        unotifi_send_unshake_close(fd);
        close(fd);
        return 0;
    }

    /* INTERACTIVE MODE */
    printf("[+] Connected to minitd service (UNOTIFI mode)\n");
    printf("[+] Type commands interactively. Press Ctrl+D to exit.\n\n");

    char buf[BUF_SIZE];

    while (1) {
        printf("minit> ");
        fflush(stdout);

        if (!fgets(buf, sizeof(buf), stdin)) {
            printf("\nExiting...\n");
            break;
        }

        /* Strip trailing newline */
        size_t len = strlen(buf);
        while (len > 0 && (buf[len - 1] == '\n' || buf[len - 1] == '\r')) {
            buf[--len] = '\0';
        }

        if (len == 0) continue; /* Ignore empty lines! */

        if (unotifi_send_data(fd, buf) != UNOTIFI_OK) {
            printf("[ ERROR ] Failed to send command to minitd\n");
            break;
        }

        char *resp = NULL;
        int res = unotifi_recv_data(fd, &resp);
        if (res == UNOTIFI_OK && resp) {
            printf("%s\n", resp);
            free(resp);
        } else if (res == UNOTIFI_ERR_PROTOCOL) {
            printf("[ SERVER ERROR ] Unknown or invalid command\n");
        } else {
            printf("[ Connection closed by server ]\n");
            break;
        }
    }

    unotifi_send_unshake_close(fd);
    close(fd);
    return 0;
}