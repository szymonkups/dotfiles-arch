#!/bin/bash

# Utilities
link_directory() {
	[ ! -d $2 ] && ln -s $1 $2
}

link_file() {
	[ ! -f $2 ] && ln -s $1 $2
}

OFFICIAL_INSTALL=""
install_from_official() {
    OFFICIAL_INSTALL="$OFFICIAL_INSTALL $@"
}

AUR_INSTALL=""
install_from_aur() {
    AUR_INSTALL="$AUR_INSTALL $@"
}

mkdir -p $HOME/.config

# Gather things to install
for f in software/**/install.sh ; do
    source $f
done;

# Install from official repository
sudo pacman -S --noconfirm $OFFICIAL_INSTALL

# Install Yay
if ! command -v yay &> /dev/null
then
	git clone https://aur.archlinux.org/yay.git 
	cd yay 
	makepkg -si
	cd ..
    rm -rf yay
else
	echo "yay installed, skipping..."
fi

# # Install from AUR
# yay -S --noconfirm $AUR_INSTALL

# Execute all configurations
# Gather things to install
for f in software/**/configure.sh ; do
    source $f
done;


# TODO:
# SCREEN size config
# BSPWM monitor config
# ssh and gpg key config
# POLYBAR CONFIG
# DMENU installation
# notification system
# backup found cofig files
# git setup (ssh, code signing, name)
# neovim config
# webstorm
# firewall

# install from AUR

# yay -S --noconfirm dmenu-git > /dev/null
# yay -S --noconfirm google-chrome > /dev/null
# yay -S --noconfirm nvm > /dev/null			

# Next steps:
# run arandr and save under $HOME/.screenlayout/default.sh