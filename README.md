# minitd
- The minimal init system for your custom linux distros!

## Prebuilt shell utilities
* run-graphic-vda.sh
    - Run graphics [V]
    - Run with disk.img [V]
* run-graphic.sh
    - Run graphics [V]
    - Run with disk.img [X]
* run-vda.sh
    - Run graphics [X]
    - Run with disk.img [V]
* run.sh
    - Run graphics [X]
    - Run with disk.img [X]

## Setup
- Step 1:
```bash
git clone https://github.com/mk-2015/minitd
rm -rf base # Optoinal. for testinh dont remove
```

- Step 2:
```bash
make #-j4
# cmake
```

## Output
- main file: bin/init

## Service and Target Configuration

minitd loads service units from `/etc/minitd/services/*.svc` during early service startup.

Example service file (`.svc`):
```ini
IGNORE=0
Name=ExampleService
Exec=/bin/sh -c "while true; do echo ExampleService is running; sleep 60; done"
Policy=always
Restart=always
RunOnTarget=basic.target
Wants=network.svc
Requires=network.svc
After=network.svc
Type=simple
```

Key points:
- `.svc` extension is required for service files to be discovered.
- `RunOnTarget` controls which target the service is eligible for.
- `Requires` makes the target service mandatory before starting.
- `After` ensures the service starts after the named dependency.
- `Wants` is a softer dependency hint, but the current runtime treats it like a dependency list.
- `Policy` can be `once` or `always`.
- `Restart` can be `no`, `always`, or `on-failure`.
- `Type` can be `simple`, `oneshot`, `forking`, or `notify`.

Targets are defined in `/etc/minitd/targetfiles/*.target`.

Example target file:
```ini
Name=BasicTarget
Level=1
Next=service.target
Isolate=0
```

Target keys:
- `Name` — human-readable target name.
- `Level` — numeric ordering for target progression.
- `Next` — next target filename to activate.
- `Isolate` — if `1`, services outside this target are stopped.
- `IGNORE` — if `1`, the target file is skipped.

Runtime behavior:
- `_start_service_early()` scans `/etc/minitd/services/*.svc` and registers matching services.
- Services are started when their `RunOnTarget` matches the active target.
- `basic.target` is the default boot target when no explicit target is selected.
- `After=network.svc` means the service runs after `network.svc` is active.
- `Requires=network.svc` means the service will not start unless `network.svc` is active.

`/etc/minitd/targetfiles/maxtarg.conf` can further control target loading:
- `LEVEL=<n>` limits target activation to this level.
- `OptFile=<target filename or Name>` selects the preferred starting target.
- `IGNORE=1` disables maxtarg constraints.

Example section syntax in MiLang:
```ini
RootVar=1
RootVar2=Root

[MySection]
MySectionVar=123
```

New configreader helpers support:
- `readkey(cfg, "RootVar")`
- `readkey(cfg, "MySection.MySectionVar")`
- `writekey(cfg, "MySection.MySectionVar", "456")`
- `deletekey(cfg, "MySection.MySectionVar")`
- `list_sections(cfg)`
- `list_keys_in_section(cfg, "MySection")`
- `list_num_key_in_section(cfg, "MySection")`
- `list_num_sections(cfg)`

## Test
- As mentioned in "Prebuilt shell utilities" there are multple shell utilities for with/out graphics and/or disk.img (/dev/vda)

## How To

### Make a USB with this init system
- Clone the repo:
```bash
git clone https://github.com/mk-2015/minitd.git
rm -rf .git
``` 

- Make the image file:
```bash
dd if=/dev/zero of="usbimg.img" bs=1M count=4096 status=progress
mkfs.ext4 -F -L "MINITD_USB" "usbimg.img"
mkdir -p "usb"
sudo mount "usbimg.img" "usb"
```

- Run pacstrap:
```bash
sudo pacstrap -c "usb" \
    base \
    glibc coreutils binutils \
    pacman python \
    grub linux linux-firmware \
    konsole xorg-server tinywm xterm \
    e2fsprogs util-linux
```

- Add minitd:
```bash
make
sudo mkdir -p "usb/sbin"
sudo cp bin/init "usb/sbin/init"
sudo chmod +x "usb/sbin/init"
```

- Add minitd configs:
```bash
sudo mkdir -p "usb/etc/minitd/services"
sudo mkdir -p "usb/etc/minitd/targetfiles"
```

- Generate fstab:
```bash
ROOT_UUID=$(blkid -s UUID -o value "usbimg.img")
echo "UUID=${ROOT_UUID}  /  ext4  rw,relatime  0  1" | sudo tee "usb/etc/fstab"
```

- Make initramfs (mkinitcpio):
```bash
sudo arch-chroot "${MOUNT_DIR}" mkinitcpio -k "$(uname -r)" -g /boot/initramfs-custom.img
```

- Configure grub:
```bash
sudo mkdir -p "usb/boot/grub"

cat <<EOF | sudo tee "usb/boot/grub/grub.cfg"
set default=0
set timeout=2

menuentry "Minit-DOS" {
    search --no-floppy --fs-uuid --set=root ${ROOT_UUID}
    linux /boot/vmlinuz-$(uname -r) root=UUID=${ROOT_UUID} rw init=/sbin/init quiet
    initrd /boot/initramfs-custom.img
}
EOF
```

- Unmount:
```bash
sudo umount -R "usb"
sync
sync
sync
```

* Flash usb and try out!

###