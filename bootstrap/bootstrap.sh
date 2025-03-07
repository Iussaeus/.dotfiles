#! /bin/bash
Red='\e[0;31m';
Gre='\e[0;32m';
Cya='\e[0;36m';
Whi='\e[0;37m';

# Synchronize package databases
echo -e "[${Red}*${Whi}] Updating system.."
sudo pacman -Syu

# Install aura AUR helper
echo -e "[${Red}+${Whi}] Installing yay"
git clone https://aur.archlinux.org/yay.git /tmp/yay-git-cloned
cd /tmp/yay-git-cloned/
makepkg -sfci --noconfirm --needed

# Install pkgs
echo -e "[${Red}+${Whi}] Installing repo packages"
for repo_pkg in $(cat ~/.dotfiles/bootstrap/pkg_lists/pkg_list)
do
	 sudo pacman -S --noconfirm --needed $repo_pkg
done

# Install pkgs from the AUR
echo -e "[${Cya}+${Whi}] Installing AUR packages"
for aur_pkg in $(cat ~/.dotfiles/bootstrap/pkg_lists/aur_pkg_list)
do
	 yay -S --noconfirm --needed $aur_pkg
done

# Make those linky-links
ln -sf $HOME/.dotfiles/.xinitrc $HOME
ln -sf $HOME/.dotfiles/.gtkrc-2.0$HOME
ln -sf $HOME/.dotfiles/i3 $HOME/.config/
ln -sf $HOME/.dotfiles/i3blocks $HOME/.config/
ln -sf $HOME/.dotfiles/i3-layout-manager $HOME/.config/
ln -sf $HOME/.dotfiles/kitty $HOME/.config/
ln -sf $HOME/.dotfiles/nvim $HOME/.config/
ln -sf $HOME/.dotfiles/Pictures $HOME
ln -sf $HOME/.dotfiles/starship.toml $HOME/.config/starship.toml
ln -sf $HOME/.dotfiles/dunst/ $HOME/.config/
ln -sf $HOME/.dotfiles/.gitconfig $HOME
ln -sf $HOME/.dotfiles/.bashrc $HOME
ln -sf $HOME/.dotfiles/.zshrc $HOME
ln -sf $HOME/.dotfiles/.bash_profile $HOME
ln -sf $HOME/.dotfiles/kritadisplayrc $HOME/.config
ln -sf $HOME/.dotfiles/kritarc $HOME/.config
ln -sf $HOME/.dotfiles/kritashortcutsrc $HOME/.config
ln -sf $HOME/.dotfiles/.ideavimrc $HOME/
ln -sf $HOME/.dotfiles/kanata $HOME/.config
ln -sf $HOME/.dotfiles/bin/ $HOME/.local/bin/

# Copy touchpad config file
sudo cp $HOME/.dotfiles/30-touchpad.conf.back /etc/X11/xorg.conf.d/30-touchpad.conf

# Copy rofi theme
sudo cp $HOME/.dotfiles/rofi/breeze-dark.rasi /usr/share/rofi/themes/

gsettings set org.gnome.desktop.interface color-scheme prefer-dark
# Get the pc speaker tf out
sudo cp $HOME/.dotfiles/nobeep.conf /etc/modprobe.d/

# enable services
sudo systemctl enable bluetooth.service
sudo systemctl enable sddm

# Change the shell to zsh
sudo chsh -s $(which zsh) john

# Remove everything but the stuff form the good_guys filter file
# ./remove_useless.sh ~

# Install tablet drivers
# echo -e "[${Cya}+${Whi}] Installing tablet driver"
#
# script_dir="$(sudo find $HOME -name scrape_me_daddy.py)"
# driver_link="$(python $script_dir)"
#
# mkdir $HOME/driver
# cd $HOME/driver
# curl -O "$driver_link"
# tar -xf "$(find . -type f -name Gaomon*)" 
# sudo sh "$(find . -type f -name install.sh)"
# rm "$(find . -type f -name Gaomon*)"
# rm -rf $HOME/driver
