########################### antidote+starship
source /opt/homebrew/share/antidote/antidote.zsh
antidote load

eval "$(starship init zsh)"
setopt CASE_GLOB

#### fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='--height 40% --layout reverse --exact --preview "bat --style=numbers --color=always --line-range :500 {}"'
##################### (OS envs)
export PATH=$HOME/matt-scripts:$HOME/bin:/opt/homebrew/opt/uutils-coreutils/libexec/uubin:$PATH
export PATH="/Users/mm/.antigravity/antigravity/bin:$PATH"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:${MANPATH}"
HIST_STAMPS="%m/%d %H:%M:%S"
export HISTSIZE=1000000
export SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups
TERM=screen-256color
export WORDCHARS='`~!@#$%^&*()-_=+[{]}\|;:",<.>/?'"'"
###################### lang evns
export GOPATH=$HOME/go
export PATH=$HOME/go/bin:$PATH

eval "$(fnm env --use-on-cd)"

# export JAVA_HOME="/opt/homebrew/opt/openjdk/libexec/openjdk.jdk/Contents/Home"
# export PATH="$JAVA_HOME/bin:$PATH"
# export PATH=/opt/gradle/gradle-8.14.3/bin:$PATH

############# aliases
alias untar='tar -zxvf'
alias v='nvim -S ~/hi/cli/editor/vimrc'
alias py='source ~/py-venv/bin/activate && python '
alias k='kubectl'
alias tf='terraform'

alias gitup="git fetch -a --force; git pull --rebase --autostash"
alias cursor="/Applications/Cursor.app/Contents/MacOS/Cursor"
############ functions
function unset_proxy {
  unset http_proxy
  unset https_proxy
  unset no_proxy
}

###########
echo "hi!" # to make sure the file is sourced
