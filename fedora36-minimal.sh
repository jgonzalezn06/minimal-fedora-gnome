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
REMOVE="nano yum"
dnf remove -y ${REMOVE}
mv *.repo /etc/yum.repos.d
dnf install -y fedora-workstation-repositories https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm && dnf clean all && dnf makecache
rpm --import https://packages.microsoft.com/keys/microsoft.asc
dnf config-manager --add-repo https://packages.microsoft.com/yumrepos/edge
dnf update --refresh

#PACKAGES GROUPS AND INSTALL

dnf install -y $(cat packages/*_fedora)
systemctl set-default graphical.target
systemctl enable crond
systemctl enable libvirtd
mv config/ssh-key.conf /etc/ssh/ssh_config.d

# Font Install RobotoMono y HacknerdFont
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/RobotoMono.zip && wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip
mkdir /usr/share/fonts/RobotoMono /usr/share/fonts/HackNerdFont
unzip RobotoMono.zip -d /usr/share/fonts/RobotoMono && rm -rf RobotoMono.zip && unzip Hack.zip -d /usr/share/fonts/HackNerdFont && rm -rf Hack.zip

#USER
read -p "ingresa el nombre de usuario: " USERNAME
if [ $(ls /home | grep $USERNAME) = $USERNAME ] ; then
   echo "si existe el usuario"
   usermod $USERNAME -s /usr/bin/zsh
   usermod root -s /usr/bin/zsh
   git clone https://github.com/zsh-users/zsh-autosuggestions /home/$USERNAME/.zsh/zsh-autosuggestions
   git clone https://github.com/vinceliuice/Colloid-gtk-theme.git
   # CONFIG MOVE
   mkdir -p /home/$USERNAME/.config/terminator/
   mv Colloid-gtk-theme /home/$USERNAME/
   mv config/terminator.config /home/$USERNAME/.config/terminator/config
   mv config/.zshrc /home/$USERNAME/.zshrc
   ln -s /home/$USERNAME/.zshrc /root/.zshrc
   ln -s /home/$USERNAME/.zsh /root/.zsh
   chown -R $USERNAME: /home/$USERNAME
   usermod -aG wheel $USERNAME
fi
   

