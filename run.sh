#!/usr/bin/env bash

make -j4

cp bin/init base/rootfs/init

cd rootfs
find . -print0 | cpio --null -ov --format=newc | gzip -9 > ../initramfs.cpio.gz

cd ..
qemu-system-x86_64 \
    -kernel /boot/vmlinuz-6.18-x86_64 \
    -initrd initramfs.cpio.gz \
    -append "console=ttyS0 panic=1" \
    -drive file=base/ramfile.img,index=1,media=disk,format=raw,if=virtio \
    -nographic

