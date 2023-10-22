TF_A_PLAT=qemu
TF_A_DEBUG=1
ifeq ($(TF_A_DEBUG),0)
TF_A_BUILD_TYPE=release
else
TF_A_BUILD_TYPE=debug
endif

phony+=build_tf-a
build_tf-a:
	$(MAKE) -C $(TFASRC) BUILD_BASE=$(TFADIR) CROSS_COMPILE=$(CROSS_COMPILE) DEBUG=$(TF_A_DEBUG) PLAT=qemu
	cp $(TFADIR)/$(TF_A_PLAT)/$(TF_A_BUILD_TYPE)/bl1.bin $(TOPDIR)/
	cp $(TFADIR)/$(TF_A_PLAT)/$(TF_A_BUILD_TYPE)/bl2.bin $(TOPDIR)/
	cp $(TFADIR)/$(TF_A_PLAT)/$(TF_A_BUILD_TYPE)/bl31.bin $(TOPDIR)/

phony+=clean_tf-a
clean_tf-a:
	$(MAKE) -C $(TFASRC) BUILD_BASE=$(TFADIR) CROSS_COMPILE=$(CROSS_COMPILE) PLAT=qemu realclean
	rm -f bl1.bin bl2.bin bl31.bin
