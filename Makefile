# Common
TOPDIR			:=$(CURDIR)
BUILDDIR		:=$(TOPDIR)/build
NPROC			:=$(shell nproc)

# Toolchain
TOOLCHAIN		:=$(TOPDIR)/aarch64-none-linux-gnu
CROSS_COMPILE	:=$(TOOLCHAIN)/bin/aarch64-none-linux-gnu-
ARCH			:=arm64
OD				:=$(CROSS_COMPILE)objdump
OC				:=$(CROSS_COMPILE)objcopy

# Qemu
QSRC			:=$(TOPDIR)/qemu
QDIR			:=$(BUILDDIR)/qemu
include scripts/build/qemu.mk

# edk2
EDK2SRC			:=$(TOPDIR)/edk2
include scripts/build/edk2.mk

# Arm-Trusted-Firmware
TFASRC			:=$(TOPDIR)/arm-trusted-firmware
TFADIR			:=$(BUILDDIR)/arm-trusted-firmware
include scripts/build/tf-a.mk

# Linux
KSRC			:=$(TOPDIR)/linux
KDIR			:=$(BUILDDIR)/linux
include scripts/build/linux.mk

# Buildroot
BSRC			:=$(TOPDIR)/buildroot
BDIR			:=$(BUILDDIR)/buildroot
include scripts/build/buildroot.mk

# execute scripts
include scripts/run/qemu.mk
include scripts/run/nfs.mk

all:

.PHONY: $(phony)
