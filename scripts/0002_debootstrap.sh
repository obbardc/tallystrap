. ./functions.sh

echo_info "Debootstrapping system"

# debootstrap a basic Debian system
debootstrap --arch=arm64 --foreign buster $ROOTFS

# copy in the ARM static binary (so we can chroot)
cp /usr/bin/qemu-aarch64-static $ROOTFS/usr/bin/

# actually install the packages
chroot_exec /debootstrap/debootstrap --second-stage