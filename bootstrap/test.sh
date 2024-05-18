# Install pkgs from the AUR
echo -e "[${Cya}+${Whi}] Installing AUR packages"
for aur_pkg in $(cat ~/.dotfiles/bootstrap/pkg_lists/aur_pkg_list)
do
	yay -S --noconfirm --needed $aur_pkg
done

