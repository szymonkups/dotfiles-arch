read -p "Git user name to set: " gituser
read -p "Git user email to set: " gitemail
git config --global user.name "$gituser"
git config --global user.email $gitemail