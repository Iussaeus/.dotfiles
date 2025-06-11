#! /bin/env bash

Red='\e[0;31m';
Gre='\e[0;32m';
Cya='\e[0;36m';
Whi='\e[0;37m';

pre-install() {
	echo -e "[${Red}*${Whi}] Updating system.."
	sudo pacman -Syu

	if ! pacman -Q git &> /dev/null; then
		sudo pacman -S --noconfirm --needed git
	fi

	if pacman -Q yay &>/dev/null; then
		echo -e "[${Red}+${Whi}] Found yay, skipping installation..."
	else 
		echo -e "[${Red}+${Whi}] Installing yay"
		git clone https://aur.archlinux.org/yay.git /tmp/yay-git-cloned
		cd /tmp/yay-git-cloned/
		makepkg -sfci --noconfirm --needed
	fi
}


install-base-pkgs() {
	echo -e "[${Red}+${Whi}] Installing repo packages"
	for repo_pkg in $(cat $HOME/.dotfiles/bootstrap/pkg_lists/pkg_list)
	do
		 sudo pacman -S --noconfirm --needed $repo_pkg
	done
}

install-base-aur-pkgs() {
	echo -e "[${Cya}+${Whi}] Installing AUR packages"
	for aur_pkg in $(cat $HOME/.dotfiles/bootstrap/pkg_lists/aur_pkg_list)
	do
		yay -S --noconfirm --needed $aur_pkg
	done
}

install-i3-pkgs() {
	echo -e "[${Cya}+${Whi}] Installing i3 packages"
	for aur_pkg in $(cat $HOME/.dotfiles/bootstrap/pkg_lists/i3_aur_pkg_list)
	do
		yay -S --noconfirm --needed $aur_pkg
	done

	# Copy rofi theme
	sudo cp /home/john/.dotfiles/stow/bash/rofi/breeze-dark.rasi /usr/share/rofi/themes/

}

install-hyprland-pkgs() {
	echo -e "[${Cya}+${Whi}] Installing hyprland packages"
	for aur_pkg in $(cat $HOME/.dotfiles/bootstrap/pkg_lists/hypr_aur_pkg_list)
	do
		yay -S --noconfirm --needed $aur_pkg
	done
}

post-install() {
	local wm=$1
	
	local stow_wm_dir="$HOME/.dotfiles/stow-wm"
	local stow_dir="$HOME/.dotfiles/stow"
	
	local old_pwd=$(pwd)
	cd $stow_dir
	
	case $wm in
		"i3") stow -v -d $stow_wm_dir -t $HOME i3 ;; 
		"hyprland") stow -v -d $stow_wm_dir -t $HOME hyprland
	esac

	stow -v -d $stow_dir -t $HOME *

	cd $old_pwd

	# Copy touchpad config file
	sudo cp $HOME/.dotfiles/30-touchpad.conf.back /etc/X11/xorg.conf.d/30-touchpad.conf

	ln -sf $HOME/.dotfiles/Pictures $HOME

	# Get the pc speaker tf out
	sudo cp $HOME/.dotfiles/nobeep.conf /etc/modprobe.d/

	# enable services
	sudo systemctl enable bluetooth.service
	sudo systemctl enable sddm

	# Change the shell to zsh
	chsh -s $(which zsh)
}

install-i3() {
	pre-install
	install-base-pkgs
	install-base-aur-pkgs
	install-i3-pkgs
	post-install "i3"
}

install-hyprland() {
	pre-install
	install-base-pkgs
	install-base-aur-pkgs
	install-hyprland-pkgs
	post-install "hyprland"

	systemctl enable --now com.system76.PowerDaemon.service
	hyprpm reload
	hyprpm add https://github.com/outfoxxed/hy3
	hyprpm enable hy3
}

read -p "What wm (1)i3, (2)hyprland: " choice

case $choice in
	1) install-i3 ;;
	2) install-hyprland ;;
	*)
		echo "wrong option bucko"
		exit 1
esac
