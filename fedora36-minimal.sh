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

#PACKAGES GROUPS AND INSTALL
WORK_CONSOLE='fping git openfortivpn curl squid wget neovim rsync telnet htop zsh'
WORK_PROGRAM='filezilla pgadmin3 cherrytree chromium firefox virt-viewer vlc python-vlc terminator'
AMD_DRIVER='mesa-dri-drivers mesa-filesystem mesa-libEGL mesa-libGL mesa-libgbm mesa-libglapi mesa-libxatracker mesa-vulkan-drivers vulkan-loader'
GNOME='evince gedit nautilus file-roller gnome-calculator @base-x gnome-shell chrome-gnome-shell gnome-tweaks gnome-extension-app gdm'
VBOX='@development-tools kernel-headers kernel-devel dkms elfutils-libelf-devel qt5-qtx11extras VirtualBox-6.1'

dnf install -y "$WORK_CONSOLE $WORK_PROGRAM $AMD_DRIVER $GNOME $VBOX"
systemctl set-default graphical.target


# VIRTUALBOX PERMISOS
usermod -aG vboxusers,wheel jgonzalez && newgrp vboxusers


# ZSH y POWERLEVEL10K y Terminal
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
