#!/bin/bash

# Este script instala un entorno de escritorio GNOME minimo para fedora 36 server 

# Conectividad hacia internet
ping -c1 www.google.cl >> /dev/null
if [ $(echo $?) -eq 0 ] ; then
  echo "Si existe conectividad hacia internet"
  else
  echo "no existe conectividad hacia internet, Saliendo del script"
  exit 1
fi
# PENDIENTE GENERAR FUNCION PARA COMRPOBAR DIRECTORIOS Y FICHEROS

# Clean Packages y repositorios
REMOVE="vim-minimal vim-data nano yum"
dnf remove -y ${REMOVE}
mv *.repo /etc/yum.repos.d
dnf install -y fedora-workstation-repositories https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm && dnf clean all && dnf makecache

#PACKAGES GROUPS AND INSTALL

dnf install -y $(cat packages/*_fedora)
systemctl set-default graphical.target
systemctl enable crond
systemctl enable libvirtd

# Font Install RobotoMono y HacknerdFont
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/RobotoMono.zip && wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip
mkdir /usr/share/fonts/RobotoMono /usr/share/fonts/HackNerdFont
unzip RobotoMono.zip -d /usr/share/fonts/RobotoMono && rm -rf RobotoMono.zip && unzip Hack.zip -d /usr/share/fonts/HackNerdFont && rm -rf Hack.zip

#USER
read -p "ingresa el nombre de usuario: " USERNAME
if [ $USERNAME -eq $(ls /home | grep "$USERNAME") ] ; then
   echo "si existe el usuario"
   usermod $USERNAME -s /usr/bin/zsh
   usermod root -s /usr/bin/zsh
   git clone https://github.com/zsh-users/zsh-autosuggestions /home/"$USERNAME"/.zsh/zsh-autosuggestions
   # CONFIG MOVE
   mkdir -p /home/"$USERNAME"/.config/terminator/
   mv config/terminator.config /home/"$USERNAME"/.config/terminator/config
   mv config/.zshrc /home/"$USERNAME"/.zshrc
   ln -s /home/$USERNAME/.zshrc /root/.zshrc
   ln -s /home/$USERNAME/.zsh /root/.zsh
   chown -R "$USERNAME": /home/"$USERNAME"
   usermod -aG wheel $USERNAME
fi
   
   

