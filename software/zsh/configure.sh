chsh -s /usr/bin/zsh

rm $HOME/.zshrc
link_file `pwd`/software/zsh/home/.zshrc $HOME/.zshrc