#!/usr/bin/env bash

make -j4

cp bin/init base/rootfs/init

cd rootfs
find . -print0 | cpio --null -ov --format=newc | gzip -9 > ../initramfs.cpio.gz

cd ..
qemu-system-x86_64 \
    -full-screen \
    -kernel /boot/vmlinuz-6.18-x86_64 \
    -initrd initramfs.img \
    -append "console=tty0 panic=1 nokaslr" \


