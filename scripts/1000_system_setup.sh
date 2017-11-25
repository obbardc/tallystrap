. ./functions.sh

# set hostname
echo "orangepi" > $ROOTFS/etc/hostname

# set root password
PASSWORD="toor"
ENCRYPTED_PASSWORD=`mkpasswd -m sha-512 "${PASSWORD}"`
chroot_exec usermod -p "${ENCRYPTED_PASSWORD}" root

# mount root filesystem
echo "/dev/mmcblk0p1	/	ext4	defaults,noatime	0	1" > $ROOTFS/etc/fstab

# setup wired network (dhcp)
echo "
# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
allow-hotplug eth0
iface eth0 inet dhcp" >> $ROOTFS/etc/interfaces

# setup apt
echo "deb http://ftp.uk.debian.org/debian buster main
deb-src http://ftp.uk.debian.org/debian buster main" > $ROOTFS/etc/apt/sources.list

# update repo
#chroot_exec apt-get update

# install ssh server
#chroot_exec apt-get install openssh-server --yes --force-yes

