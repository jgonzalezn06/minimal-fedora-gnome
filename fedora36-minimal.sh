#!/bin/bash

# Repositorios de fedora workstation y mas

mv *.repo /etc/yum.repos.d
dnf install -y fedora-workstation-repositories
dnf clean all && dnf -y update

# Font Install RobotoMono y HacknerdFont

mkdir /usr/share/fonts/RobotoMono /usr/share/fonts/HackNerdFont
mv *.zip /usr/share/fonts/
# Instalacion de aplicativos para trabajo
dnf install -y virt-viewer fping git openfortivpn squid chromium firefox evince wget pgadmin3 cherrytree nautilus neovim rsync

# solo para intel
# dnf group install -y "Hardware Support"

# gnome minimal
dnf install -y @base-x gnome-shell gdm
systemctl set-default graphical.target

# drivers
dnf install -y vulkan mesa-dri-drivers mesa-filesystem mesa-libEGL mesa-libGL mesa-libgbm mesa-libglapi mesa-libxatracker mesa-vulkan-drivers vulkan-loader

# Opciones de nautilus "abrir terminal"
# dnf install -y gnome-terminal-nautilus xdg-user-dirs xdg-user-dirs-gtk ffmpegthumbnailer

# Instalacion de gnome-tweaks y opciones de gnome en chrome
dnf install -y chrome-gnome-shell gnome-tweaks @development-tools

# calculadora monitor gedit pdf y file-roller
dnf install -y gnome-calculator gnome-system-monitor gedit evince file-roller 

# VLC
dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
dnf install -y vlc python-vlc

# VIRTUALBOX
sudo dnf install kernel-headers kernel-devel gcc glibc-headers
sudo dnf install -y @development-tools && sudo dnf -y install kernel-headers kernel-devel dkms elfutils-libelf-devel qt5-qtx11extras
dnf install -y VirtualBox-6.1

usermod -aG vboxusers,wheel jgonzalez && newgrp vboxusers


# ZSH y POWERLEVEL10K y Terminal
dnf install -y zsh terminator
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestio
echo 'source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh' >>~/.zshrc
cat >> ~/.zshrc << EOF
# historial 
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# Home, End and Del Key Bindings Fedora
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey "\e[3~" delete-char

# Forward and Backward - word with ALT
# bindkey "^[[1;3C" forward-word
# bindkey "^[[1;3D" backward-word

# Forward and Backward - word CTRL	
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
EOF

mkdir -p ~/.config/terminator/
cat > ~/.config/terminator/config << EOF

EOF
# CREACION de usuario

usermod root -s /usr/bin/zsh
usermod jgonzalez -s /usr/bin/zsh
ln -s /root/.zshrc /home/jgonzalez/.zshrc
chown root: /root
chown jgonzalez: /home/jgonzalez



# Cherrytree

sudo dnf install 


reboot
