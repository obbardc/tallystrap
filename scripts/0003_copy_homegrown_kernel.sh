. ./functions.sh

KERNEL_TMP="$CWD/tmp_kernel"

if [ ! -d "$KERNEL_TMP" ]; then
    info "cannot find built kernel, please use tallykernel"
    exit 1
fi


# copy kernel & dtb
mkdir $ROOTFS/boot/
cp $KERNEL_TMP/linux/arch/arm64/boot/Image $ROOTFS/boot/
cp $KERNEL_TMP/linux/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dtb $ROOTFS/boot/

# copy kernel modues
cp $KERNEL_TMP/linux/compiled_modules/* rootfs/ -R

# copy boot script

# copy this into rootfs/boot/boot.cmd

cat <<'EOF' >> $ROOTFS/boot.cmd
echo "This is your bootloader speaking."
echo "---------------"
echo "All your sunxi are belong to us."
echo "---------------"
echo "booting..."

setenv bootargs "console=tty0 console=tty1 console=ttyS0,115200 hdmi.audio=EDID:0 disp.screen0_output_mode=1280x720p60 root=/dev/mmcblk0p1 rootwait panic=10"

ext4load mmc 0:1 0x11000000 Image
ext4load mmc 0:1 0x1000000 sun50i-h5-orangepi-pc2.dtb
fdt addr 0x1000000

booti 0x11000000 - 0x1000000
EOF

$KERNEL_TMP/u-boot/tools/mkimage -C none -A arm64 -T script -d $ROOTFS/boot/boot.cmd $ROOTFS/boot/boot.scr


dd if=$KERNEL_TMP/u-boot/u-boot-sunxi-with-spl.bin of=$IMAGE bs=8k seek=1
sync