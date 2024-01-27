rm $HOME/.xinitrc
link_file `pwd`/software/xorg/home/.xinitrc $HOME/.xinitrc

rm -rf $HOME/.Xresources
link_file `pwd`/software/xorg/home/.Xresources $HOME/.Xresources