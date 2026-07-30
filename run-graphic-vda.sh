#!/usr/bin/env bash
set -e

SKIP_BUILD=0

while getopts "n" opt; do
  case ${opt} in
    n)
      SKIP_BUILD=1
      ;;
    \?)
      echo "Usage: $0 [-n]"
      exit 1
      ;;
  esac
done

if [ "$SKIP_BUILD" -eq 0 ]; then
    make -j4
    cp bin/init base/rootfs/init
    sudo make prepmkinit
fi

qemu-system-x86_64 \
    -full-screen \
    -kernel /boot/vmlinuz-6.18-x86_64 \
    -initrd base/initramfs.img \
    -append "root=/dev/vda rw console=tty0 nokaslr init=/init" \
    -drive file=base/disk.img,format=raw,if=virtio