. ./functions.sh

KERNEL_TMP="$CWD/tmp_kernel"

if [ ! -d "$KERNEL_TMP" ]; then
    info "cannot find built kernel, please use tallykernel"
    exit 1
fi


# copy kernel & dtb
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

setenv load_addr "0x44000000"
#setenv bootargs "console=ttyS0,115200 console=tty0 disp.screen0_output_mode=1280x720p60 root=/dev/mmcblk0p2 panic=10"
setenv bootargs "console=ttyS0,115200 noinitrd root=/dev/mmcblk0p2 rootfstype=ext4 rw rootwait"

load mmc 0:1 ${load_addr} Image
load mmc 0:1 ${fdt_addr_r} sun50i-h5-orangepi-pc2.dtb
fdt addr ${fdt_addr_r}


booti ${load_addr} - ${fdt_addr_r}
EOF

$KERNEL_TMP/u-boot/tools/mkimage -C none -A arm64 -T script -d $ROOTFS/boot/boot.cmd $ROOTFS/boot/boot.scr


