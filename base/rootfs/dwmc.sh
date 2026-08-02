export WLR_BACKENDS=headless
export WLR_RENDERER=pixman
export LIBGL_ALWAYS_SOFTWARE=1

# 2. Re-verify runtime nodes are mapped out
mkdir -p /run/user/0 /dev/shm
mount -t tmpfs tmpfs /dev/shm 2>/dev/null || true
export XDG_RUNTIME_DIR=/run/user/0
chmod 700 /run/user/0