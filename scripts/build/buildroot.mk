phony+=rconfig
rconfig:
	$(MAKE) -C $(BSRC) O=$(BDIR) qemu_aarch64_virt_custom_defconfig

phony+=rmenuconfig
rmenuconfig: rconfig
	$(MAKE) -C $(BSRC) O=$(BDIR) menuconfig

phony+=rbuild
rbuild: rconfig
	$(MAKE) -C $(BSRC) O=$(BDIR) -j $(NPROC)

phony+=rclean
rclean:
	$(MAKE) -C $(BSRC) O=$(BDIR) distclean
	rm -rf $(BDIR)
