QEMU	:=$(QDIR)/qemu-system-aarch64
MACHIN	:=virt
CPU		:=cortex-a53
SMP		:=1
RAM		:=1G
IMG		:=$(KDIR)/arch/arm64/boot/Image
FDT		:=
ROOTFS	:=$(BDIR)/images/rootfs.ext4
BOOTARGS:="rootwait root=/dev/vda console=ttyAMA0"
QFLAG	:=-netdev user,id=eth0 -device virtio-net-device,netdev=eth0 
QFLAG	+=-drive file=$(ROOTFS),if=none,format=raw,id=hd0 -device virtio-blk-device,drive=hd0

run: $(IMG) $(ROOTFS)
	$(QEMU) -M $(MACHIN) -cpu $(CPU) -smp $(SMP) -m $(RAM) -kernel $(IMG) -append $(BOOTARGS) $(QFLAG) -nographic