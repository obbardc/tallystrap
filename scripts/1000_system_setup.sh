. ./functions.sh

# set hostname
echo "orangepi" > $ROOTFS/etc/hostname

# set root password
PASSWORD="toor"
ENCRYPTED_PASSWORD=`mkpasswd -m sha-512 "${PASSWORD}"`
chroot_exec usermod -p "${ENCRYPTED_PASSWORD}" root

# setup apt
#echo "deb http://ftp.uk.debian.org/debian buster main
#deb-src http://ftp.uk.debian.org/debian buster main" > $ROOTFS/etc/apt/sources.list

# update repo
#chroot_exec apt-get update

# install ssh server
#chroot_exec apt-get install openssh-server --yes --force-yes

