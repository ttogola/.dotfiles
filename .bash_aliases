#TODO: fix completion
alias e='grep -E'
alias h='history'
alias i='irssi'
alias l='ls -ahlrt'
alias q='exit'
alias c='clear'
alias t="tmux -2"
alias ta="tmux attach"
alias ty="gtypist"
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias imap='offlineimap -o'
alias lk='gnome-screensaver-command -l'
alias off='sudo shutdown -P now'
alias offon='sudo shutdown -r now'

# dev / temp
#upower -i /org/freedesktop/UPower/devices/battery_BAT0
alias g++='g++ -Wall -g -std=c++11'
alias xmd='xmodmap ~/.Xmodmap'

# let sudo use the user-set PATH
alias sudo='sudo env PATH=$PATH'
