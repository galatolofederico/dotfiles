# tmux
[[ $- != *i* ]] && return
[[ -z "$TMUX" && "$TERM" != "linux" ]] && exec tmux

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# load aliases
[ -f ~/.bash_aliases ] && source ~/.bash_aliases
# load functions
[ -f ~/.bash_functions ] && source ~/.bash_functions

# env variables
export EDITOR=vim
export PATH=$PATH:/home/federico/bin:/home/federico/.local/bin
# autocd
shopt -s autocd


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
