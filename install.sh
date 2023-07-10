#!/bin/bash

install() {

	if pacman -Qs $1 > /dev/null ; then
  		echo $1 installed, skipping...
	else
		echo $1 not installed, installing...
		sudo pacman -S $1 --noconfirm > /dev/null
	fi
}

# Install from official repository
install git
install vim
install nodejs
install xorg-server

# To set root cursor
install xorg-xsetroot

# To put cursor in center of the screen on start
install xdotool

install bspwm
install sxhkd
install alacritty
install openssh
install polybar
install noto-fonts
install lxappearance-gtk3

# Audio via pipewire
install pipewire
install pipewire-alsa
install pipewire-pulse
install wireplumber
systemctl --user enable --now pipewire

# Use it to create a default display configuration
install arandr

#install zsh
install zsh
if [[ "$SHELL" != "/bin/zsh" ]]
then
	chsh -s /bin/zsh
else
	echo "zsh already set as shell, skipping..."
fi

# install oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install yay
install base-devel
git clone https://aur.archlinux.org/yay.git 
cd yay 
makepkg -si
cd ..

# install from aur

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
