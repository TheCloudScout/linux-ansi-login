Update repos

    sudo apt-get update && sudo apt-get -y upgrade

Install additional packages
    
    sudo apt-get install -y figlet lolcat neofetch
    git clone https://github.com/xero/figlet-fonts
    mv figlet-fonts/* /usr/share/figlet/ && rm -rf figlet-fonts
    
Show all installed fonts
    
    showfigfonts
    
Wortell Enterprise Security logo
 
    /usr/bin/figlet "Wortell" -f larry3d -w 140 | /usr/games/lolcat -f -p 6 -S 47
    /usr/bin/figlet "           Enterprise Security" -f miniwi -w 140 | /usr/games/lolcat -f -p 6 -S 47
    
Use logo as part of Message of the Day

    printf "\n$(cat /home/logstash/wortell-ansi-figlet-2 | /usr/games/lolcat -f -p 6 -S 47)\n"

Place extra MOTD files in /etc/update-motd.d

    00-header
    01-neofetch
    02-weather

Add execute permissions

    sudo chmod +x /etc/update-motd.d/*
