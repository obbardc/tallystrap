. ./functions.sh

# set hostname
echo "tallystrap-test" > $ROOTFS/etc/hostname

# set root password
chroot_exec echo "root:toor" | chpasswd

# setup apt
echo "deb http://ftp.uk.debian.org/debian buster main
deb-src http://ftp.uk.debian.org/debian buster main" > $ROOTFS/etc/apt/sources.list

# update repo
chroot_exec apt-get update

# install ssh server
chroot_exec apt-get install openssh-server --yes --force-yes

