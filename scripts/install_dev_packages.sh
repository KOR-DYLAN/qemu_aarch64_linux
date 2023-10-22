#!/bin/bash
echo "installing common packages..."
sudo apt update
sudo apt upgrade -y
sudo apt install build-essential gcc-multilib g++-multilib gdb cmake llvm lldb clang \
                 libncurses5 libncurses5-dev libncursesw5 libncursesw5-dev bison flex u-boot-tools \
                 libssl-dev python3-dev python2.7-dev net-tools git vim neovim unzip font-manager \
                 mkisofs curl ssh meson tree language-pack-en language-pack-ko -y

echo "installing python3.8 packages..."
sudo add-apt-repository ppa:deadsnakes/ppa -y
sudo apt update
sudo apt install python3.8 -y

echo "installing i386 packages..."
sudo dpkg --add-architecture i386
sudo apt list --upgradable
sudo apt-get update
sudo apt-get install libc6:i386 libncurses5:i386 libstdc++6:i386 -y