#!/bin/bash

set -e

echo "ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/student

APT_FLAGS="-qq -y -o Dpkg::Use-Pty=0"
export DEBIAN_FRONTEND=noninteractive
apt-get $APT_FLAGS update
apt-get $APT_FLAGS install git build-essential kernel-package \
                               fakeroot libncurses5-dev libssl-dev ccache libelf-dev

git clone --depth 1 --branch v4.4 git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
chown -R vagrant linux-stable
cd linux-stable

cp /boot/config-$(uname -r) .config
yes "" | make oldconfig
make -j $(getconf _NPROCESSORS_ONLN) deb-pkg LOCALVERSION=-ericsz2

cd ..
dpkg -i linux-image-4.4.0-*_4.4.0-*_amd64.deb
dpkg -i linux-headers-4.4.0-*_4.4.0-*_amd64.deb

grub-reboot '1>4' && sudo reboot
