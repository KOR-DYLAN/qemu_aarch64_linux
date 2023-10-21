phony+=build_edk2
build_edk2:
	cd $(EDK2SRC) && ./build.sh $(TOPDIR) $(CROSS_COMPILE)

phony+=clean_edk2
clean_edk2:
	rm -rf edk2/Build bl33.bin
