# Install tablet drivers
echo -e "[${Cya}+${Whi}] Installing tablet driver"

script_dir="$(sudo find $HOME -name scrape_me_daddy.py)"
driver_link="$(python $script_dir)"

mkdir $HOME/driver
cd $HOME/driver
curl -O "$driver_link"
tar -xf "$(find . -type f -name Gaomon*)" 
sudo sh "$(find . -type f -name install.sh)"
rm "$(find . -type f -name Gaomon*)"
