phony+=kconfig
kconfig:
	$(MAKE) -C $(KSRC) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) O=$(KDIR) qemu_aarch64_virt_custom_defconfig

phony+=kmenuconfig
kmenuconfig: kconfig
	$(MAKE) -C $(KSRC) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) O=$(KDIR) menuconfig

phony+=kbuild
kbuild: kconfig
	$(MAKE) -C $(KSRC) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) O=$(KDIR) -j $(NPROC)
	$(OD) -x $(KDIR)/vmlinux | more > $(KDIR)/vmlinux.hdr
	$(OD) -d $(KDIR)/vmlinux | more > $(KDIR)/vmlinux.asm

phony+=kclean
kclean:
	$(MAKE) -C $(KSRC) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) O=$(KDIR) distclean
