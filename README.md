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

## Test
- As mentioned in "Prebuilt shell utilities" there are multple shell utilities for with/out graphics and/or disk.img (/dev/vda)
