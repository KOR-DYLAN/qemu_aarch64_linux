#!/bin/bash
export PYTHON_COMMAND=python3
make -C BaseTools

source edksetup.sh --reconfig

export GCC5_AARCH64_PREFIX=$2
build -a AARCH64 -t GCC5 -p ArmVirtPkg/ArmVirtQemuKernel.dsc

cp Build/ArmVirtQemuKernel-AARCH64/DEBUG_GCC5/FV/QEMU_EFI.fd $1/bl33.bin
