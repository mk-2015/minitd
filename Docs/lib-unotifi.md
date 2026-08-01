# libunotifi

`libunotifi` is a minimal UNIX-domain socket-based library for service notifications and communication using the UNOTIFI protocol.

## Installation

Build as part of the `minitd` project using the existing `libs/` CMake support. The library lives in:

- `libs/include/libunotifi/unotifi.h`
- `libs/src/libunotifi/unotifi.c`

## Protocol Overview

The UNOTIFI protocol is a lightweight text-based handshake and messaging protocol for service-to-service communication.

### Connection setup

1. Service A obtains a UNIX socket path from `getServiceUnix("service-a")`.
2. Service A calls `openCommunicationChannel(socket_path)` to connect.
3. Service B listens using `createServiceUnixSocket("service-b")` and accepts with `acceptCommunicationChannel(listen_fd)`.

### Handshake

Service A sends:

```text
SUPPORT UNOTIFI
SHAKE PACKET

inf:
mypid: <my-pid>
service name: <name>
```

Service B responds:

```text
SUPPORT UNOTIFI
SHAKE OK

inf:
<its-info>
```

Once the response is received, the connection is established.

### Disconnect flow

Client (Service A) sends:

```text
UNSHAKE
CONNECTION CLOSE FINAL
```

Responder (Service B) sends:

```text
UNSHAKE WAIT
CONNECTION WAIT
FINISHING
```

When Service B is ready to close, it sends:

```text
UNSHAKE OK
CONNECTION CLOSE PERMISSION
```

Then Service A may close the UNIX socket.

### BEAT packets

Service A sends:

```text
BEAT 1
```

Service B replies:

```text
BEAT OK
```

### DATA packets

Service A sends:

```text
DATA SEND
PROTOCOL SEND

BEGIN DATA
<DATA>
```

Service B replies:

```text
DATA RESPONSE
PROTOCOL RESPONSE

BEGIN RESPONSE
<DATA>
```

## API

### `getServiceUnix`

Returns a heap-allocated UNIX socket path string for a service name. Caller must `free()`.

### `createServiceUnixSocket`

Creates and binds a UNIX domain socket for a service and begins listening.

### `openCommunicationChannel`


### `acceptCommunicationChannel`
Opens a client-side UNIX socket to the target socket path.

Accepts an incoming connection on a listening service socket.

### Handshake helpers

- `unotifi_send_handshake(fd, pid, service_name)`
- `unotifi_recv_handshake(fd, &info)`

### Disconnect helpers

- `unotifi_send_unshake_close(fd)`
- `unotifi_send_unshake_wait(fd)`
- `unotifi_send_unshake_ok(fd)`
- `unotifi_recv_unshake(fd, &response)`

### Heartbeat helpers

- `unotifi_send_beat(fd)`
- `unotifi_recv_beat(fd)`

### Data helpers

- `unotifi_send_data(fd, data)`
- `unotifi_send_response(fd, data)`
- `unotifi_recv_data(fd, &payload)`

## Notes

- This implementation uses `/tmp/unotifi/<service>.sock` as the default UNIX socket location.
- The library is intentionally minimal and protocol-oriented.

