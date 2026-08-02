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
    cp -r bin/* base/rootfs/bin/
    sudo make prepmkinit
fi

# Route console to tty0 so your Shell process outputs to the full-screen window
sudo qemu-system-x86_64 \
    -full-screen \
    -kernel /boot/vmlinuz-6.18-x86_64 \
    -initrd base/initramfs.img \
    -append "root=/dev/vda rw console=tty0 nokaslr init=/init modeset=1" \
    -drive file=base/disk.img,format=raw,if=virtio \
    -drive file=base/ramfile.img,index=1,media=disk,format=raw,if=virtio \
    -netdev tap,id=net0,ifname=tap0,script=no,downscript=no \
    -device virtio-net-pci,netdev=net0 \
    -device virtio-gpu-pci \
    -display sdl