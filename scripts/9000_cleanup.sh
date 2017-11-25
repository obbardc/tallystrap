. ./functions.sh

# show used disk space
df -h | grep $ROOTFS

# remove qemu binary
rm $ROOTFS/usr/bin/qemu-aarch64-static

info "Completed system setup!"