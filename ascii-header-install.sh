# Let's start by installing all the latest updates
sudo apt-get update && sudo apt-get -y upgrade
# Install Figlet, Lolcat, Neofetch and JQ to create a nice ascii MOTD header
sudo apt-get install -y figlet lolcat neofetch jq
# Download additional Figlet fonts
git clone https://github.com/xero/figlet-fonts
sudo mv figlet-fonts/* /usr/share/figlet/ && rm -rf figlet-fonts
# Generate an ascii logo with Figlet and add some color with Lolcat
/usr/bin/figlet "Wortell" -f larry3d -w 140 | /usr/games/lolcat -f -p 6 -S 47 >> wortell-figlet.txt
/usr/bin/figlet "           Enterprise Security" -f small -w 140 | /usr/games/lolcat -f -p 6 -S 47 >> wortell-figlet.txt
# We won't be needing these MOTD modules anymore
sudo rm /etc/update-motd.d/00-header
sudo rm /etc/update-motd.d/10-help-text
sudo rm /etc/update-motd.d/50-landscape-sysinfo
sudo rm /etc/update-motd.d/50-motd-news
sudo rm /etc/update-motd.d/80-livepatch
# Create new 00-header file with the ascii logo
HOME=~
echo '#!/bin/bash' >> 00-header
echo 'cat '"$HOME"'/wortell-figlet.txt | /usr/games/lolcat -f -p 6 -S 47' >> 00-header
echo 'printf "\n"' >> 00-header
# Create 01-neofetch for sysinfo 
echo '#!/bin/bash' >> 01-neofetch
echo '/usr/bin/neofetch --color_blocks off' >> 01-neofetch
# Create 02-weather for real-time weather report
# First get local city based on IP
CITYquoted=$(curl -s https://ipvigilante.com/$(curl -s https://ipinfo.io/ip) | jq '.data.city_name')
# Remove leading and trailing quotes
CITY="${CITYquoted%\"}"
CITY="${CITY#\"}"
# And create 02-weather file
echo '#!/bin/bash' >> 02-weather
echo 'printf "\n"' >> 02-weather
echo 'curl wttr.in/'"$CITY"'?0 --silent --max-time 3' >> 02-weather
# Move the MOTD modules to their correct location
sudo mv -t /etc/update-motd.d/ 00-header 01-neofetch 02-weather
# And make sure these new modules can be executed
sudo chmod +x /etc/update-motd.d/00-header
sudo chmod +x /etc/update-motd.d/01-neofetch
sudo chmod +x /etc/update-motd.d/02-weather
sudo chown root:root /etc/update-motd.d/*
