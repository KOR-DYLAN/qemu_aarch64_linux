# Common
TOPDIR			:=$(CURDIR)
BUILDDIR		:=$(TOPDIR)/build
NPROC			:=$(shell nproc)

# Toolchain
TOOLCHAIN		:=$(TOPDIR)/aarch64-none-linux-gnu
CROSS_COMPILE	:=$(TOOLCHAIN)/bin/aarch64-none-linux-gnu-
ARCH			:=arm64

# Qemu
QSRC			:=$(TOPDIR)/qemu
QDIR			:=$(BUILDDIR)/qemu
include scripts/build/qemu.mk

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

all:

.PHONY: $(phony)
