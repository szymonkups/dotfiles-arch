#!/bin/bash

install() {
	if pacman -Qs $1 > /dev/null ; then
  		echo $1 installed, skipping...
	else
		echo $1 not installed, installing...
		sudo pacman -S $1 --noconfirm > /dev/null
	fi
}

link_directory() {
	[ ! -d $2 ] && ln -s $1 $2
}

link_file() {
	[ ! -f $2 ] && ln -s $1 $2
}

mkdir -p $HOME/.config

#################################################
# Install yay
#################################################
if ! command -v yay &> /dev/null
then
	git clone https://aur.archlinux.org/yay.git 
	cd yay 
	makepkg -si
	cd ..
else
	echo "yay installed, skipping..."
fi

#################################################
# Install tools from official repository
#################################################
install git
install neovim	
install base-devel	
install man-db
install bspwm						# Tiled window manager
install sxhkd
install openssh
install polybar
install lxappearance-gtk3
install nitrogen
install wmname

#################################################
# Fonts
#################################################
install noto-fonts
install ttf-jetbrains-mono
install otf-droid-nerd

#################################################
# Xorg
#################################################
install xorg-server
install xorg-xsetroot 				# Used to set root cursor
install xdotool						# To put the cursor on screen's center at start
install arandr

link_file `pwd`/.xinitrc $HOME/.xinitrc
link_file `pwd`/configs/.Xresources $HOME/.Xresources

#################################################
# Pipewire
#################################################
install pipewire
install pipewire-alsa
install pipewire-pulse
install wireplumber
systemctl --user enable --now pipewire

#################################################
# Alacritty
#################################################
install alacritty
link_directory `pwd`/configs/alacritty $HOME/.config/alacritty

#################################################
# Node.js
#################################################
install nodejs
install npm
sudo npm install -g n # TODO: setup global modules without sudo
sudo n 16 # TODO: use without sudo

#################################################
# ZSH, oh-my-zsh
#################################################
install zsh
if [[ "$SHELL" != "/bin/zsh" ]]
then
	echo "setting zsh as default shell..."
	chsh -s /bin/zsh
else
	echo "zsh already set as shell, skipping..."
fi

if [ -d "~/.oh-my-zsh" ] 
then
	echo "installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "oh-my-zsh installed, skipping..."
fi

link_directory `pwd`/configs/bspwm $HOME/.config/bspwm
link_directory `pwd`/configs/sxhkd $HOME/.config/sxhkd
link_directory `pwd`/configs/polybar $HOME/.config/polybar


# TODO:
# .zshrc
# SCREEN size config
# BSPWM config
# POLYBAR CONFIG
# DMENU installation
# notification system
# alacritty configuration
# backup found cofig files
# git setup (ssh, code signing, name)
# neovim config
# automatic wallpaper
# webstorm

# install from AUR

# yay -S --noconfirm dmenu-git > /dev/null
# yay -S --noconfirm google-chrome > /dev/null
# yay -S --noconfirm nvm > /dev/null