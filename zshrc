##################### oh-my-zsh,fzf
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="agnoster"
CASE_SENSITIVE="true"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=black,bold'

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true
DISABLE_AUTO_TITLE="true"


plugins=(git zsh-syntax-highlighting zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='--height 40% --layout reverse --exact --preview "bat --style=numbers --color=always --line-range :500 {}"'
##################### (prompt)
build_prompt() {
  RETVAL=$?
  prompt_status
  prompt_virtualenv
  #tf_prompt_info
  #prompt_context
  prompt_dir
  prompt_git
  prompt_bzr
  prompt_hg
  prompt_end
}
PROMPT='%{%f%r%k%}$(build_prompt) '
##################### (OS envs)
export PATH=$HOME/matt-scripts:$HOME/bin:/opt/homebrew/opt/findutils/libexec/gnubin:$PATH
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

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# export JAVA_HOME="/opt/homebrew/opt/openjdk/libexec/openjdk.jdk/Contents/Home"
# export PATH="$JAVA_HOME/bin:$PATH"
# export PATH=/opt/gradle/gradle-8.14.3/bin:$PATH

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/$USER/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions
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

function gitc() {
  local task_id=${TASK_ID:-DEVEX-3276}

  local prefix=$1
  local message=$2

  date=$(date +%Y-%m-%d-%H%M%S)
  branch="${prefix}/${task_id}-${date}"
  git checkout -b "$branch" || exit 1
  git commit -m "${prefix}: [${task_id}] ${message}"
  git push --set-upstream origin "$branch"
  gh pr create --fill
}
###########
echo "hi!" # to make sure the file is sourced
