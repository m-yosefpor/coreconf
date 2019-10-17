l() { ls -lh --color=always "$@" | awk '{print $5, $9$10$11}' | column -t | column;}
la() { ls -Alh --color=always "$@" | awk '{print $5, $9$10$11}' | column -t | column;}

c() { cd "$@" && l ; } 
alias ..='c ..'
alias ...='c ../../'

x() { exec "$@" >/dev/null 2>&1 & } 

alias i='sudo apt update && sudo apt install'
ii() { sudo apt-get install -y "$@" 1>/dev/null; }
alias ui='sudo apt remove'

alias g=grep
alias le='less -R'

#alias e=echo
#alias h=head

alias s='sudo ' # for using sudo + alias


alias kvpn='sudo pkill openconnect'
alias cvpn='ps -A | g openconnect'
alias cnet='ping -c 1 8.8.8.8 | g time= | awk '\''{print $7}'\'' '


alias untar='tar -zxvf'
alias gitup='git add --all && git commit -m "up" && git pull origin master && git push origin master'

alias py='python3'
alias p='source ~/py-venv/bin/activate && python '
alias j='source ~/py-venv/bin/activate && python -m jupyter notebook '
alias d='sudo docker'
alias v='vim'
alias tele='x telegram-desktop'

#####

