#!/bin/bash

install() {

	if pacman -Qs $1 > /dev/null ; then
  		echo $1 installed, skipping...
	else
		echo $1 not installed, installing...
		sudo pacman -S $1 --noconfirm > /dev/null
	fi
}


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
# Install from official repository
#################################################
install git
install nvim	
install base-devel	
install nodejs
install xorg-server
install xorg-xsetroot 				# Used to set root cursor
install xdotool						# To put the cursor on screen's center at start
install bspwm						# Tiled window manager
install sxhkd
install alacritty
install openssh
install polybar
install noto-fonts
install lxappearance-gtk3
install arandr

#################################################
# Pipewire
#################################################
install pipewire
install pipewire-alsa
install pipewire-pulse
install wireplumber
systemctl --user enable --now pipewire

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

# install oh my zsh
if [ -d "~/.oh-my-zsh" ] 
then
	echo "installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "oh-my-zsh installed, skipping..."
fi

# install from AUR

yay -S --noconfirm dmenu-git > /dev/null
yay -S --noconfirm google-chrome > /dev/null

# link configuration files
ln -s `pwd`/.xinitrc $HOME/.xinitrc

mkdir -p $HOME/.config

# TODO: Rename to *_bak if exists
ls -s `pwd`/configs/bspwm $HOME/.config/bspwm
ls -s `pwd`/configs/sxhkd $HOME/.config/sxhkd

# Set root cursor size here
ls -s `pwd`/configs/.Xresources $HOME/.Xresources
