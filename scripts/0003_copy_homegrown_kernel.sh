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

cat <<'EOF' >> $ROOTFS/boot/boot.cmd
echo "This is your bootloader speaking."
echo "---------------"
echo "All your sunxi are belong to us."
echo "---------------"
echo "booting..."

setenv bootargs "console=ttyS0,115200 console=tty0 disp.screen0_output_mode=1280x720p60 root=/dev/mmcblk0p1 panic=10"

load mmc 0:1 0x11000000 boot/Image
load mmc 0:1 0x1000000 boot/sun50i-h5-orangepi-pc2.dtb
fdt addr 0x1000000


booti 0x11000000 - 0x1000000
EOF

$KERNEL_TMP/u-boot/tools/mkimage -C none -A arm64 -T script -d $ROOTFS/boot/boot.cmd $ROOTFS/boot.scr


