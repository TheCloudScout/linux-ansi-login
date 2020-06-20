Install packages
    
    sudo apt-get install figlet && apt-get install lolcat
    git clone https://github.com/xero/figlet-fonts
    mv figlet-fonts/* figlet && rm -rf figlet-fonts
    
   Show all installed fonts
    
    showfigfonts
    
 Wortell Enterprise Security logo
 
    /usr/bin/figlet "Wortell" -f larry3d -w 140 | /usr/games/lolcat -f -p 6 -S 47
    /usr/bin/figlet "           Enterprise Security" -f miniwi -w 140 | /usr/games/lolcat -f -p 6 -S 47
    
Use logo as part of Message of the Day

    printf "\n$(cat /home/logstash/wortell-ansi-figlet-2 | /usr/games/lolcat -f -p 6 -S 47)\n"

Place extra MOTD files in /etc/update-motd.d
