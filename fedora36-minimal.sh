#!/bin/bash

# Repositorios de fedora workstation y mas
# dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

mv *.repo /etc/yum.repos.d
dnf install -y fedora-workstation-repositories https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
dnf clean all && dnf -y update

# Font Install RobotoMono y HacknerdFont

mkdir /usr/share/fonts/RobotoMono /usr/share/fonts/HackNerdFont
unzip RobotoMono.zip -d /usr/share/fonts/RobotoMono && rm -rf RobotoMono.zip
unzip Hack.zip -d /usr/share/fonts/HackNerdFont && rm -rf Hack.zip

# Instalacion de aplicativos para trabajo
dnf install -y virt-viewer fping git openfortivpn curl squid chromium firefox evince wget pgadmin3 cherrytree nautilus neovim rsync filezilla telnet gedit htop gnome-calculator evince file-roller @base-x gnome-shell gdm vulkan mesa-dri-drivers mesa-filesystem mesa-libEGL mesa-libGL mesa-libgbm mesa-libglapi mesa-libxatracker mesa-vulkan-drivers vulkan-loader chrome-gnome-shell gnome-tweaks @development-tools dnf install vlc python-vlc
systemctl set-default graphical.target


# VIRTUALBOX PERMISOS
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

# solo para intel
# dnf group install -y "Hardware Support"


reboot
