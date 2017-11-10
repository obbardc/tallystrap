info() {
    echo "TALLYMAN: $*"
}

error() {
    echo "TALLYMAN ERROR: $*"
}

chroot_exec() {
    LANG=C LC_ALL=C DEBIAN_FRONTEND=noninteractive chroot ${ROOTFS} $*
}