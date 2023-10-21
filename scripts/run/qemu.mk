QEMU		:=$(QDIR)/qemu-system-aarch64
MACHIN		:=virt
CPU			:=cortex-a72
GIC			:=3
SMP			:=4
RAM			:=1G
VIRT		:=on
SECURE		:=on
IMG			:=$(KDIR)/arch/arm64/boot/Image
FDT_BASE	:=$(TOPDIR)/resource/qemu-system-aarch64
FDT			:=$(FDT_BASE).dtb
ROOTFS		:=$(BDIR)/images/rootfs.ext4
BOOTARGS	:="rootwait root=/dev/vda console=ttyAMA0"
QFLAG		:=-netdev user,id=eth0 -device virtio-net-device,netdev=eth0 
QFLAG		+=-drive file=$(ROOTFS),if=none,format=raw,id=hd0 -device virtio-blk-device,drive=hd0

run: $(IMG) $(ROOTFS)
	$(QEMU) -M $(MACHIN),gic-version=$(GIC),virtualization=$(VIRT),secure=$(SECURE) -cpu $(CPU) -smp $(SMP) -m $(RAM) -kernel $(IMG) -append $(BOOTARGS) $(QFLAG) -nographic

extract_fdt:
	$(QEMU) -M $(MACHIN) -cpu $(CPU) -smp $(SMP) -m $(RAM) $(QFLAG) -machine dumpdtb=$(FDT)
	dtc -I dtb -O dts -o $(FDT_BASE).dts $(FDT_BASE).dtb
