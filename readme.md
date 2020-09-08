## Installation

Please use *ascii-header-install.sh* for a fully automated installation.

---
## What this script does:

### Update repos

    sudo apt-get update && sudo apt-get -y upgrade

### Install additional packages like Figlet, Lolcat and Neofetch
    
    sudo apt-get install -y figlet lolcat neofetch

_Figlet is an application which can gegerate ascii-art-like logo's from text_

_Lolcat will add rainbow colors to your output_

_Neofetch generates a nice ascii sysinfo_


### Download additional Figlet fonts
    
    git clone https://github.com/xero/figlet-fonts
    mv figlet-fonts/* /usr/share/figlet/ && rm -rf figlet-fonts

### Generate Wortell Enterprise Security ascii logo with Figlet and add some color with Lolcat
    
    /usr/bin/figlet "Wortell" -f larry3d -w 140 | /usr/games/lolcat -f -p 6 -S 47 >> wortell-figlet.txt
    /usr/bin/figlet "           Enterprise Security" -f small -w 140 | /usr/games/lolcat -f -p 6 -S 47 >> wortell-figlet.txt

_Notice how two different fonts are used. The logo is stored in ~/wortell-figlet.txt_

### We won't be needing these MOTD modules anymore...
    
    sudo rm /etc/update-motd.d/00-header
    sudo rm /etc/update-motd.d/10-help-text
    sudo rm /etc/update-motd.d/50-landscape-sysinfo
    sudo rm /etc/update-motd.d/50-motd-news
    sudo rm /etc/update-motd.d/80-livepatch

### ...we're building new ones

#### Create new 00-header file with the ascii logo

_Set HOME variable because that's where the ansi art resides_

    HOME=~

_And add the appropriate lines to the 00-header_

    echo '#!/bin/bash' >> 00-header
    echo 'cat '"$HOME"'/wortell-figlet.txt | /usr/games/lolcat -f -p 6 -S 47' >> 00-header
    echo 'printf "\n"' >> 00-header
    
#### Create 01-neofetch for sysinfo 

_Nothing special just disabling Neofetch color blocks because it looks better IMHO_

    echo '#!/bin/bash' >> 01-neofetch
    echo '/usr/bin/neofetch --color_blocks off' >> 01-neofetch

#### Create 02-weather for real-time weather report

_We want a weather report based on the location of the server. So let's first find the local city_
_First we found our public IP then we find the local city based of that IP_
    
    CITYquoted=$(curl -s https://ipvigilante.com/$(curl -s https://ipinfo.io/ip) | jq '.data.city_name')

_The string contains leading and trailing double quotes, we need to remove these_

    CITY="${CITYquoted%\"}"
    CITY="${CITY#\"}"

_And create 02-weather file_

    echo '#!/bin/bash' >> 02-weather
    echo 'printf "\n"' >> 02-weather
    echo 'curl wttr.in/'"$CITY"'?0 --silent --max-time 3' >> 02-weather

### Move the MOTD modules to their correct location

    sudo mv -t /etc/update-motd.d/ 00-header 01-neofetch 02-weather

### And make sure these new modules can be executed

    sudo chmod +x /etc/update-motd.d/00-header
    sudo chmod +x /etc/update-motd.d/01-neofetch
    sudo chmod +x /etc/update-motd.d/02-weather
    sudo chown root:root /etc/update-motd.d/*

---
## Aditional help

### Show all installed Figlet fonts
    
    showfigfonts
