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
for aur_pkg in $(cat ~/.dotfiles/.assets/pkg_lists/aur_pkg_list)
do
	sudo yay -S --noconfirm --needed $aur_pkg
done

# Install tablet drivers
driver_link="$(python ./scrape_me_daddy.py)"

echo $driver_link
curl -O "$driver_link"
mkdir ./driver
tar -xf "$(find . -type f -name Gaomon*)" -C ./driver
sh "$(find . -type f -name install.sh)"

# Put the cron into it's place
crontab ../crontab

# Make those linky-links
./links.sh
