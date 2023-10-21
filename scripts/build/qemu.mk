# packages
QPACKAGES	:=libslirp-dev 
QPACKAGES	+=libglib2.0-dev 
QPACKAGES	+=libfdt-dev 
QPACKAGES	+=libpixman-1-dev 
QPACKAGES	+=zlib1g-dev 
QPACKAGES	+=ninja-build
QPACKAGES	+=git-email 
QPACKAGES	+=libbluetooth-dev 
QPACKAGES	+=libcapstone-dev 
QPACKAGES	+=libbrlapi-dev 
QPACKAGES	+=libbz2-dev
QPACKAGES	+=libaio-dev 
QPACKAGES	+=libcap-ng-dev 
QPACKAGES	+=libcurl4-gnutls-dev 
QPACKAGES	+=libgtk-3-dev
QPACKAGES	+=libibverbs-dev 
QPACKAGES	+=libjpeg8-dev 
QPACKAGES	+=libncurses5-dev 
QPACKAGES	+=libnuma-dev
QPACKAGES	+=librbd-dev 
QPACKAGES	+=librdmacm-dev
QPACKAGES	+=libsasl2-dev 
QPACKAGES	+=libsdl2-dev 
QPACKAGES	+=libseccomp-dev 
QPACKAGES	+=libsnappy-dev 
QPACKAGES	+=libssh-dev
QPACKAGES	+=libvde-dev 
QPACKAGES	+=libvdeplug-dev 
QPACKAGES	+=libvte-2.91-dev 
QPACKAGES	+=libxen-dev 
QPACKAGES	+=liblzo2-dev
QPACKAGES	+=xfslibs-dev 
QPACKAGES	+=valgrind 
QPACKAGES	+=libnfs-dev 
QPACKAGES	+=libiscsi-dev
QPACKAGES	+=python3-venv

# option
QCONFIG		+=--enable-fdt=auto 
QCONFIG		+=--enable-kvm 
QCONFIG		+=--enable-lto 
QCONFIG		+=--enable-malloc=system 

# target
QTARTGET	:=aarch64-softmmu

qconfig:
	mkdir -p $(QDIR)
	sudo apt-get update
	sudo apt build-dep qemu -y
	sudo apt install $(QPACKAGES) -y
	cd $(QDIR) && $(QSRC)/configure --target-list=$(QTARTGET) $(QCONFIG)

qbuild: qconfig
	$(MAKE) -C $(QDIR) -j $(NPROC)