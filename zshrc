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
  prompt_context
  prompt_dir
  prompt_git
  prompt_bzr
  prompt_hg
  prompt_end
}
PROMPT='%{%f%r%k%}$(build_prompt) '
##################### (OS envs)
export PATH=/opt/homebrew/opt/findutils/libexec/gnubin:/Users/mm/Library/Python/3.8/bin:$PATH
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:${MANPATH}"
HIST_STAMPS="%m/%d %H:%M:%S"
export HISTSIZE=1000000
export SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups
TERM=screen-256color
export WORDCHARS='`~!@#$%^&*()-_=+[{]}\|;:",<.>/?'"'"
###################### lang evns
export GOPATH=$HOME/go
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# export JAVA_HOME="/opt/homebrew/opt/openjdk/libexec/openjdk.jdk/Contents/Home"
# export PATH="$JAVA_HOME/bin:$PATH"
############# aliases
alias untar='tar -zxvf'
alias v='nvim -S ~/hi/cli/editor/vimrc'
alias py='source ~/py-venv/bin/activate && python '
alias k='kubectl'
alias tf='terraform'
############ functions
function unset_proxy {
  unset http_proxy
  unset https_proxy
  unset no_proxy
}
###########
echo "hi!" # to make sure the file is sourced
