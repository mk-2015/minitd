#include <libunotifi/unotifi.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <sys/stat.h>
#include <errno.h>

#define UNOTIFI_BUFFER_SIZE 4096

static int write_all(int fd, const void *buf, size_t len) {
    const char *ptr = buf;
    size_t written = 0;
    while (written < len) {
        ssize_t ret = write(fd, ptr + written, len - written);
        if (ret <= 0) return UNOTIFI_ERR_IO;
        written += ret;
    }
    return UNOTIFI_OK;
}

static int read_line(int fd, char *buf, size_t cap) {
    size_t idx = 0;
    while (idx + 1 < cap) {
        ssize_t ret = read(fd, &buf[idx], 1);
        if (ret <= 0) return UNOTIFI_ERR_IO;
        if (buf[idx] == '\n') {
            buf[idx] = '\0';
            return idx;
        }
        idx++;
    }
    buf[cap - 1] = '\0';
    return UNOTIFI_ERR_PROTOCOL;
}

char *getServiceUnix(const char *service_name) {
    if (!service_name) return NULL;

    const char *base = "/tmp/unotifi";
    size_t len = strlen(base) + strlen(service_name) + 16;
    char *path = calloc(1, len);
    if (!path) return NULL;
    snprintf(path, len, "%s/%s.sock", base, service_name);
    return path;
}

int createServiceUnixSocket(const char *service_name) {
    if (!service_name) return UNOTIFI_ERR;

    char *path = getServiceUnix(service_name);
    if (!path) return UNOTIFI_ERR;

    int fd = socket(AF_UNIX, SOCK_STREAM, 0);
    if (fd < 0) {
        free(path);
        return UNOTIFI_ERR_IO;
    }

    struct sockaddr_un addr;
    memset(&addr, 0, sizeof(addr));
    addr.sun_family = AF_UNIX;
    strncpy(addr.sun_path, path, sizeof(addr.sun_path) - 1);

    char *dir_end = strrchr(path, '/');
    if (dir_end) {
        *dir_end = '\0';
        mkdir(path, 0755);
        *dir_end = '/';
    }

    unlink(path);
    if (bind(fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
        close(fd);
        free(path);
        return UNOTIFI_ERR_IO;
    }

    if (listen(fd, 4) < 0) {
        close(fd);
        unlink(path);
        free(path);
        return UNOTIFI_ERR_IO;
    }

    free(path);
    return fd;
}

int openCommunicationChannel(const char *socket_path) {
    if (!socket_path) return UNOTIFI_ERR;

    int fd = socket(AF_UNIX, SOCK_STREAM, 0);
    if (fd < 0) return UNOTIFI_ERR_IO;

    struct sockaddr_un addr;
    memset(&addr, 0, sizeof(addr));
    addr.sun_family = AF_UNIX;
    strncpy(addr.sun_path, socket_path, sizeof(addr.sun_path) - 1);

    if (connect(fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
        close(fd);
        return UNOTIFI_ERR_IO;
    }

    return fd;
}

int acceptCommunicationChannel(int listen_fd) {
    if (listen_fd < 0) return UNOTIFI_ERR;
    int client_fd = accept(listen_fd, NULL, NULL);
    if (client_fd < 0) return UNOTIFI_ERR_IO;
    return client_fd;
}

static int unotifi_send_block(int fd, const char *packet) {
    if (!packet) return UNOTIFI_ERR;
    size_t len = strlen(packet);
    return write_all(fd, packet, len);
}

int unotifi_send_handshake(int fd, pid_t pid, const char *service_name) {
    if (fd < 0 || !service_name) return UNOTIFI_ERR;

    char packet[UNOTIFI_BUFFER_SIZE];
    int n = snprintf(packet, sizeof(packet),
        "SUPPORT UNOTIFI\n"
        "SHAKE PACKET\n"
        "\n"
        "inf:\n"
        "mypid: %d\n"
        "service name: %s\n"
        "\n",
        (int)pid, service_name);

    return (n > 0 && n < (int)sizeof(packet)) ? unotifi_send_block(fd, packet) : UNOTIFI_ERR_PROTOCOL;
}

int unotifi_recv_handshake(int fd, char **info_out) {
    if (fd < 0 || !info_out) return UNOTIFI_ERR;

    char line[UNOTIFI_BUFFER_SIZE];
    if (read_line(fd, line, sizeof(line)) < 0) return UNOTIFI_ERR_PROTOCOL;
    if (strcmp(line, "SUPPORT UNOTIFI") != 0) return UNOTIFI_ERR_PROTOCOL;

    if (read_line(fd, line, sizeof(line)) < 0) return UNOTIFI_ERR_PROTOCOL;
    if (strcmp(line, "SHAKE OK") != 0 && strcmp(line, "SHAKE PACKET") != 0) return UNOTIFI_ERR_PROTOCOL;

    if (read_line(fd, line, sizeof(line)) < 0) return UNOTIFI_ERR_PROTOCOL;
    if (line[0] != '\0') return UNOTIFI_ERR_PROTOCOL;

    size_t info_cap = UNOTIFI_BUFFER_SIZE;
    char *info = calloc(1, info_cap);
    if (!info) return UNOTIFI_ERR;
    size_t offset = 0;

    while (read_line(fd, line, sizeof(line)) >= 0) {
        if (line[0] == '\0') break;
        size_t chunk = strlen(line);
        if (offset + chunk + 3 >= info_cap) break;
        offset += snprintf(info + offset, info_cap - offset, "%s\n", line);
    }

    *info_out = info;
    return UNOTIFI_OK;
}

int unotifi_send_unshake_close(int fd) {
    if (fd < 0) return UNOTIFI_ERR;
    return unotifi_send_block(fd,
        "UNSHAKE\n"
        "CONNECTION CLOSE FINAL\n");
}

int unotifi_send_unshake_wait(int fd) {
    if (fd < 0) return UNOTIFI_ERR;
    return unotifi_send_block(fd,
        "UNSHAKE WAIT\n"
        "CONNECTION WAIT\n"
        "FINISHING\n");
}

int unotifi_send_unshake_ok(int fd) {
    if (fd < 0) return UNOTIFI_ERR;
    return unotifi_send_block(fd,
        "UNSHAKE OK\n"
        "CONNECTION CLOSE PERMISSION\n");
}

int unotifi_recv_unshake(int fd, char **response_out) {
    if (fd < 0 || !response_out) return UNOTIFI_ERR;

    char line[UNOTIFI_BUFFER_SIZE];
    size_t info_cap = UNOTIFI_BUFFER_SIZE;
    char *info = calloc(1, info_cap);
    if (!info) return UNOTIFI_ERR;
    size_t offset = 0;

    while (read_line(fd, line, sizeof(line)) >= 0) {
        size_t chunk = strlen(line);
        if (offset + chunk + 3 >= info_cap) break;
        offset += snprintf(info + offset, info_cap - offset, "%s\n", line);
        if (strcmp(line, "CONNECTION CLOSE PERMISSION") == 0 ||
            strcmp(line, "FINISHING") == 0) {
            break;
        }
    }

    *response_out = info;
    return UNOTIFI_OK;
}

int unotifi_send_beat(int fd) {
    if (fd < 0) return UNOTIFI_ERR;
    return unotifi_send_block(fd, "BEAT 1\n");
}

int unotifi_recv_beat(int fd) {
    if (fd < 0) return UNOTIFI_ERR;
    char line[UNOTIFI_BUFFER_SIZE];
    if (read_line(fd, line, sizeof(line)) < 0) return UNOTIFI_ERR_PROTOCOL;
    return strcmp(line, "BEAT OK") == 0 ? UNOTIFI_OK : UNOTIFI_ERR_PROTOCOL;
}

int unotifi_send_data(int fd, const char *data) {
    if (fd < 0 || !data) return UNOTIFI_ERR;
    char packet[UNOTIFI_BUFFER_SIZE];
    int n = snprintf(packet, sizeof(packet),
        "DATA SEND\n"
        "PROTOCOL SEND\n"
        "\n"
        "BEGIN DATA\n"
        "%s\n"
        "\n",
        data);
    return (n > 0 && n < (int)sizeof(packet)) ? unotifi_send_block(fd, packet) : UNOTIFI_ERR_PROTOCOL;
}

int unotifi_send_response(int fd, const char *data) {
    if (fd < 0 || !data) return UNOTIFI_ERR;
    char packet[UNOTIFI_BUFFER_SIZE];
    int n = snprintf(packet, sizeof(packet),
        "DATA RESPONSE\n"
        "PROTOCOL RESPONSE\n"
        "\n"
        "BEGIN RESPONSE\n"
        "%s\n"
        "\n",
        data);
    return (n > 0 && n < (int)sizeof(packet)) ? unotifi_send_block(fd, packet) : UNOTIFI_ERR_PROTOCOL;
}

int unotifi_recv_data(int fd, char **payload_out) {
    if (fd < 0 || !payload_out) return UNOTIFI_ERR;

    char line[UNOTIFI_BUFFER_SIZE];
    if (read_line(fd, line, sizeof(line)) < 0) return UNOTIFI_ERR_PROTOCOL;
    if (strcmp(line, "DATA SEND") != 0 && strcmp(line, "DATA RESPONSE") != 0) return UNOTIFI_ERR_PROTOCOL;

    if (read_line(fd, line, sizeof(line)) < 0) return UNOTIFI_ERR_PROTOCOL;
    if (strcmp(line, "PROTOCOL SEND") != 0 && strcmp(line, "PROTOCOL RESPONSE") != 0) return UNOTIFI_ERR_PROTOCOL;

    if (read_line(fd, line, sizeof(line)) < 0) return UNOTIFI_ERR_PROTOCOL;
    if (line[0] != '\0') return UNOTIFI_ERR_PROTOCOL;

    if (read_line(fd, line, sizeof(line)) < 0) return UNOTIFI_ERR_PROTOCOL;
    if (strcmp(line, "BEGIN DATA") != 0 && strcmp(line, "BEGIN RESPONSE") != 0) return UNOTIFI_ERR_PROTOCOL;

    size_t info_cap = UNOTIFI_BUFFER_SIZE;
    char *info = calloc(1, info_cap);
    if (!info) return UNOTIFI_ERR;
    size_t offset = 0;

    while (read_line(fd, line, sizeof(line)) >= 0) {
        if (line[0] == '\0') break;
        size_t chunk = strlen(line);
        if (offset + chunk + 3 >= info_cap) break;
        offset += snprintf(info + offset, info_cap - offset, "%s\n", line);
    }

    *payload_out = info;
    return UNOTIFI_OK;
}
