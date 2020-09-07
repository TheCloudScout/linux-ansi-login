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

### We won't be needing these MOTD modules anymopre
    
    sudo rm /etc/update-motd.d/00-header
    sudo rm /etc/update-motd.d/10-help-text
    sudo rm /etc/update-motd.d/50-landscape-sysinfo

### Download our own custom MOTD modules which make use of the ascii headers

    sudo wget https://raw.githubusercontent.com/TheCloudScout/linux-asnsi-login/master/00-header --directory-prefix=/etc/update-motd.d/
    sudo wget https://raw.githubusercontent.com/TheCloudScout/linux-asnsi-login/master/01-neofetch --directory-prefix=/etc/update-motd.d/
    sudo wget  https://raw.githubusercontent.com/TheCloudScout/linux-asnsi-login/master/02-weather --directory-prefix=/etc/update-motd.d/

### And make sure these new modules can be executed

    sudo chmod +x /etc/update-motd.d/00-header
    sudo chmod +x /etc/update-motd.d/01-neofetch
    sudo chmod +x /etc/update-motd.d/02-weather

---
## Aditional help

### Show all installed Figlet fonts
    
    showfigfonts
