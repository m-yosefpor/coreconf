#!/bin/bash
##### a bash script for new os use with : bash 0_start
######################################################################
GTK=false
PYTHON=false

while test $# -gt 0; do
  case "$1" in
    gtk)
      shift
      GTK=true
    ;;
    python)
      shift
      PYTHON=true
    ;;
  esac
done
######################################################################
### updating repos
sudo apt update

sudo apt install -y \
	tmux wget curl openconnect htop xclip vim git openssh-server\
	docker.io docker-compose \
	python3 python3-dev python3-venv \
	ubuntu-restricted-extras \
	tor privoxy obfs4proxy

if $GTK ; then
### removing some apps if exist 
sudo apt remove -y firefox eog
sudo snap install firefox eog vlc telegram-desktop #evince gimp libreoffice audacity

sudo apt remove -y gedit totem rhythmbox file-roller #yelp
sudo snap remove gnome-calculator gnome-system-monitor

### install required packages
sudo apt install -y \
gnome-terminal thunderbird nautilus evince cheese \
gnome-screenshot gnome-tweak-tool brasero vim-gtk \
#gimp libreoffice openshot
fi

### make sure everything is uptodate
sudo apt -y upgrade

######################################################################
### rc files
cp cli/bashrc ~/.bashrc
cp cli/bash_aliases ~/.bash_aliases
cat cli/bash_aliases_pv >> ~/.bash_aliases
cp cli/tmux.conf ~/.tmux.conf
cp cli/vimrc ~/.vimrc

if $GTK; then
  cat gtk/vimrc-gtk >> ~/.vimrc
fi
### config git
git config --global user.name 'm-yosefpor'
git config --global user.email 'myusefpur@gmail.com'
git config --global core.editor vim
git config --global merge.tool vimdiff
### config tor
cat torrc | sudo tee -a /etc/tor/torrc >/dev/null
echo "forward-socks5 / 127.0.0.1:9050 ." > ~/.privoxy.conf
#### apps and defaults
if $GTK ; then
	sudo cp gtk/nvlc.desktop /usr/share/applications/nvlc.desktop
	cp gtk/mimeapps.list ~/.config/mimeapps.list
fi
######################################################################
#### rename and make directories
rmdir ~/Music ~/Videos ~/Pictures ~/Documents ~/Public ~/Templates
mkdir ~/0.github ~/1.other

##################### python3 modules
if $PYTHON; then
  python3 -m venv ~/py-venv
  . ~/py-venv/bin/activate
  ### need a vpn
  pip install wheel
  pip install numpy
  pip install scipy
  pip install pandas
  pip install matplotlib
  pip install numba
  pip install sympy
  pip install cython
  pip install sklearn
  pip install tensorflow
  pip install qutip
  pip install jupyter
  deactivate
fi
########
#ssh-keygen -t rsa -b 4096 -C "myusefpur@gmail.com"
#eval "$(ssh-agent -s)"
#ssh-add ~/.ssh/id_rsa
###
#xclip -sel clip < ~/.ssh/id_rsa.pub
## add ssh-key to github accoutn : #setting # ssh and gpg key # add ssh key

#################### vundle install and jedi-vim auto completion
#git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
#vim +PluginInstall +qall

#################### installing by file
#cp app/dropbox /opt/dropbox
#ln -s /opt/dropbox/dropbox.py /usr/local/bin/dropbox 'dropbox'


