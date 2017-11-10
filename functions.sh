echo_info() {
    echo "TALLYMAN: $*"
}

chroot_exec() {
    LANG=C LC_ALL=C DEBIAN_FRONTEND=noninteractive chroot ${ROOTFS} $*
}