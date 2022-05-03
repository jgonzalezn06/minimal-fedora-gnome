#!/bin/bash

#Clean Packages
REMOVE="vim-minimal vim-data yum nano"
dnf remove -y ${REMOVE}

# Repositorios de fedora workstation y mas
# dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

mv *.repo /etc/yum.repos.d
dnf install -y fedora-workstation-repositories https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
dnf makecache && dnf clean all

#PACKAGES GROUPS AND INSTALL
WORK_CONSOLE='fping git openfortivpn curl squid wget neovim rsync telnet htop zsh unzip'
WORK_PROGRAM='filezilla pgadmin3 cherrytree-future chromium firefox virt-viewer vlc python-vlc terminator libreoffice-writer libreoffice-calc'
AMD_DRIVER='mesa-dri-drivers mesa-filesystem mesa-libEGL mesa-libGL mesa-libgbm mesa-libglapi mesa-libxatracker mesa-vulkan-drivers vulkan-loader'
GNOME='evince gedit nautilus file-roller gnome-calculator @base-x gnome-shell chrome-gnome-shell gnome-tweaks gnome-extensions-app gdm'
VBOX='@development-tools kernel-headers kernel-devel dkms elfutils-libelf-devel qt5-qtx11extras VirtualBox'

dnf install -y $(echo $WORK_CONSOLE $WORK_PROGRAM $AMD_DRIVER $GNOME $VBOX)
systemctl set-default graphical.target

# Font Install RobotoMono y HacknerdFont
mkdir /usr/share/fonts/RobotoMono /usr/share/fonts/HackNerdFont
unzip RobotoMono.zip -d /usr/share/fonts/RobotoMono && rm -rf RobotoMono.zip
unzip Hack.zip -d /usr/share/fonts/HackNerdFont && rm -rf Hack.zip

#USER
read -p 'Ingresa nombre de usuario ' USERNAME
useradd $USERNAME -s -m /usr/bin/zsh
passwd $USERNAME
usermod root -s /usr/bin/zsh
ln -s /root/.zshrc /home/$USERNAME/.zshrc


# VIRTUALBOX PERMISOS
#usermod -aG vboxusers,wheel $USERNAME && newgrp vboxusers

# TERMINATOR CONFIG
mkdir -p /home/"$USERNAME"/.config/terminator/
mv terminator_config /home/"$USERNAME"/.config/terminator/

# CREACION de usuario
# chown root: /root
# chown jgonzalez: /home/jgonzalez


# solo para intel
# dnf group install -y "Hardware Support"

reboot
