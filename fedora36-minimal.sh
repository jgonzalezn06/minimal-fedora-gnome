#!/bin/bash
# Este script instala un entorno de escritorio GNOME minimo para fedora 36 server 


# Conectividad hacia internet
PING=$(ping -c1 www.google.cl)

if [ $PING -eq 0 ] ; then
  echo "Si existe conectividad hacia internet"
  else
  echo "no existe conectividad hacia internet, Saliendo del script"
  exit 1
fi

# Clean Packages y repositorios
REMOVE="vim-minimal vim-data yum nano"
dnf remove -y ${REMOVE}
mv *.repo /etc/yum.repos.d
dnf install -y fedora-workstation-repositories https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm && dnf clean all && dnf makecache

#PACKAGES GROUPS AND INSTALL

dnf install -y $(cat *fedora.txt)
systemctl set-default graphical.target

# Font Install RobotoMono y HacknerdFont
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/RobotoMono.zip && wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip
mkdir /usr/share/fonts/RobotoMono /usr/share/fonts/HackNerdFont
unzip RobotoMono.zip -d /usr/share/fonts/RobotoMono && rm -rf RobotoMono.zip && unzip Hack.zip -d /usr/share/fonts/HackNerdFont && rm -rf Hack.zip

#USER
read -p 'Ingresa nombre de usuario ' USERNAME
useradd $USERNAME -s -m /usr/bin/zsh
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

passwd $USERNAME
