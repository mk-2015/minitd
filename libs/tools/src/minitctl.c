#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <poll.h>

#define SOCKET_PATH "/run/minitd/contrl.sock"
#define BUF_SIZE 4096

int main(int argc, char **argv) {
    int fd = socket(AF_UNIX, SOCK_STREAM, 0);
    if (fd < 0) {
        perror("socket");
        return 1;
    }

    struct sockaddr_un addr;
    memset(&addr, 0, sizeof(addr));
    addr.sun_family = AF_UNIX;
    strncpy(addr.sun_path, SOCKET_PATH, sizeof(addr.sun_path) - 1);

    if (connect(fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
        perror("connect /run/minitd/contrl.sock");
        close(fd);
        return 1;
    }

    /* One-shot mode: e.g., minitctl SERVICE LIST */
    if (argc > 1) {
        char cmd[BUF_SIZE] = {0};
        for (int i = 1; i < argc; i++) {
            strncat(cmd, argv[i], sizeof(cmd) - strlen(cmd) - 1);
            if (i < argc - 1) strncat(cmd, " ", sizeof(cmd) - strlen(cmd) - 1);
        }
        strncat(cmd, "\n", sizeof(cmd) - strlen(cmd) - 1);

        write(fd, cmd, strlen(cmd));

        char resp[BUF_SIZE];
        ssize_t n = read(fd, resp, sizeof(resp) - 1);
        if (n > 0) {
            resp[n] = '\0';
            printf("%s", resp);
        }
        close(fd);
        return 0;
    }

    /* Interactive mode: stdin <-> socket forwarding */
    printf("[+] Connected to minitd socket (%s)\n", SOCKET_PATH);
    printf("[+] Type commands interactively. Press Ctrl+D to exit.\n\n");

    struct pollfd fds[2];
    fds[0].fd = STDIN_FILENO;
    fds[0].events = POLLIN;
    fds[1].fd = fd;
    fds[1].events = POLLIN;

    char buf[BUF_SIZE];

    while (1) {
        if (poll(fds, 2, -1) < 0) break;

        if (fds[0].revents & POLLIN) {
            ssize_t n = read(STDIN_FILENO, buf, sizeof(buf));
            if (n <= 0) break;
            write(fd, buf, n);
        }

        if (fds[1].revents & POLLIN) {
            ssize_t n = read(fd, buf, sizeof(buf));
            if (n <= 0) {
                printf("\n[ Connection closed by server ]\n");
                break;
            }
            write(STDOUT_FILENO, buf, n);
        }
    }

    close(fd);
    return 0;
}
