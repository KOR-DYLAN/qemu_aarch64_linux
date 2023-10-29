QEMU		:=$(QDIR)/qemu-system-aarch64
MACHIN		:=virt
CPU			:=cortex-a72
GIC			:=2
SMP			:=4
RAM			:=1G
VIRT		:=off
SECURE		:=on
BIOS		:=bl1.bin
IMG			:=$(KDIR)/arch/arm64/boot/Image
FDT_NAME	:=qemu-system-aarch64
FDT			:=$(KDIR)/arch/arm64/boot/dts/qemu/$(FDT_NAME).dtb
ROOTFS		:=$(BDIR)/images/rootfs.ext4
BOOTARGS	:="rootwait root=/dev/vda console=ttyAMA0 earlycon loglevel=8 kgdboc=ttyAMA0"
QFLAG		:=-netdev user,id=eth0 -device virtio-net-device,netdev=eth0
QFLAG		+=-drive file=$(ROOTFS),if=none,format=raw,id=hd0 -device virtio-blk-device,drive=hd0
QFLAG		+=-d unimp -semihosting-config enable=on

DEBUG_IMG	:=bl2.bin

run: $(IMG) $(ROOTFS)
	$(QEMU) -M $(MACHIN),gic-version=$(GIC),virtualization=$(VIRT),secure=$(SECURE),acpi=off -cpu $(CPU) -smp $(SMP) -m $(RAM) -bios $(BIOS) -dtb $(FDT) -kernel $(IMG) -append $(BOOTARGS) $(QFLAG) -nographic

debug: $(DEBUG_IMG) $(ROOTFS)
	$(QEMU) -M $(MACHIN),gic-version=$(GIC),virtualization=$(VIRT),secure=$(SECURE),acpi=off -cpu $(CPU) -smp $(SMP) -m $(RAM) -bios $(BIOS) -dtb $(FDT) -kernel $(DEBUG_IMG) -append $(BOOTARGS) $(QFLAG) -nographic -S -s

extract_fdt:
	$(QEMU) -M $(MACHIN),gic-version=$(GIC),virtualization=$(VIRT),secure=$(SECURE),acpi=off,dumpdtb=resource/$(FDT_NAME).dtb -cpu $(CPU) -smp $(SMP) -m $(RAM) -kernel $(IMG) -append $(BOOTARGS) -nographic
	dtc -I dtb -O dts -o resource/$(FDT_NAME).dts resource/$(FDT_NAME).dtb
	rm -f resource/$(FDT_NAME).dtb
