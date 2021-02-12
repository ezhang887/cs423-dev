#!/bin/bash

APT_FLAGS="-qq -y -o Dpkg::Use-Pty=0"
export DEBIAN_FRONTEND=noninteractive
apt-get $APT_FLAGS update
apt-get $APT_FLAGS install git build-essential kernel-package \
                               fakeroot libncurses5-dev libssl-dev ccache libelf-dev

git clone git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
cd linux-stable
git checkout v4.4
cp /boot/config-$(uname -r) .config
yes "" | make oldconfig
make -j $(getconf _NPROCESSORS_ONLN) deb-pkg LOCALVERSION=-ericsz2

cd ..
sudo dpkg -i linux-image-4.4.0-*_4.4.0-*_amd64.deb
sudo dpkg -i linux-headers-4.4.0-*_4.4.0-*_amd64.deb

sudo grub-reboot '1>4' && sudo reboot
