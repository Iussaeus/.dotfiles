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
echo -e "[${Cya}+${Whi}] Installing tablet driver"

driver_link="$(python ./scrape_me_daddy.py)"

sudo pacman -S -noconfirm --needed python-beautifulsoup4

curl -O "$driver_link"
mkdir ./driver
tar -xf "$(find . -type f -name Gaomon*)" -C ./driver
sh "$(find . -type f -name install.sh)"

sudo pacman -R -noconfirm -needed python-beautifulsoup4

# Put the cron into it's place
crontab $HOME/.dotfiles/crontab

# Make those linky-links
ln -sf $HOME/.dotfiles/i3 $HOME/.config/
ln -sf $HOME/.dotfiles/i3-layout-manager $HOME/.config/
ln -sf $HOME/.dotfiles/kitty $HOME/.config/
ln -sf $HOME/.dotfiles/nvim $HOME/.config/
ln -sf $HOME/.dotfiles/scripts $HOME
ln -sf $HOME/.dotfiles/Pictures $HOME
ln -sf $HOME/.dotfiles/starship.toml $HOME/.config/starship.toml
ln -sf $HOME/.dotfiles/dunst/ $HOME/.config/
ln -sf $HOME/.dotfiles/.gitconfig $HOME
ln -sf $HOME/.dotfiles/.bashrc $HOME
ln -sf $HOME/.dotfiles/.bash_profile $HOME

