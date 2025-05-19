#! /bin/bash
Red='\e[0;31m';
Gre='\e[0;32m';
Cya='\e[0;36m';
Whi='\e[0;37m';

# Synchronize package databases
echo -e "[${Red}*${Whi}] Updating system.."
sudo pacman -Syu

# Install yay AUR helper
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

# Copy touchpad config file
sudo cp $HOME/.dotfiles/30-touchpad.conf.back /etc/X11/xorg.conf.d/30-touchpad.conf

ln -sf $HOME/.dotfiles/Pictures $HOME

# Copy rofi theme
sudo cp /home/john/.dotfiles/stow/bash/rofi/breeze-dark.rasi /usr/share/rofi/themes/

gsettings set org.gnome.desktop.interface color-scheme prefer-dark

# Get the pc speaker tf out
sudo cp $HOME/.dotfiles/nobeep.conf /etc/modprobe.d/

# enable services
sudo systemctl enable bluetooth.service
sudo systemctl enable sddm

# Change the shell to zsh
chsh -s $(which zsh)
