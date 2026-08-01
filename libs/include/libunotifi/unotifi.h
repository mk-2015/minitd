#ifndef __LIBUNOTIFI_H__
#define __LIBUNOTIFI_H__

#include <sys/types.h>
#include <stdbool.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef enum {
    UNOTIFI_OK = 0,
    UNOTIFI_ERR = -1,
    UNOTIFI_ERR_IO = -2,
    UNOTIFI_ERR_PROTOCOL = -3
} UnotifiResult;

char *getServiceUnix(const char *service_name);
int createServiceUnixSocket(const char *service_name);
int openCommunicationChannel(const char *socket_path);
int acceptCommunicationChannel(int listen_fd);

int unotifi_send_handshake(int fd, pid_t pid, const char *service_name);
int unotifi_recv_handshake(int fd, char **info_out);

int unotifi_send_unshake_close(int fd);
int unotifi_send_unshake_wait(int fd);
int unotifi_send_unshake_ok(int fd);
int unotifi_recv_unshake(int fd, char **response_out);

int unotifi_send_beat(int fd);
int unotifi_recv_beat(int fd);

int unotifi_send_data(int fd, const char *data);
int unotifi_send_response(int fd, const char *data);
int unotifi_recv_data(int fd, char **payload_out);

#ifdef __cplusplus
}
#endif

#endif
