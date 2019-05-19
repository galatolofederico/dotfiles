# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# load aliases
[ -f ~/.bash_aliases ] && source ~/.bash_aliases
# load functions
[ -f ~/.bash_functions ] && source ~/.bash_functions
# load private aliases
[ -f ~/.private_aliases ] && source ~/.private_aliases

# cd into last directory
cd $(cat /tmp/whereami)

# env variables
export EDITOR=vim
export TERMINAL=st
export PATH=$PATH:$HOME/bin:$HOME/.local/bin

# save last direcotry
export PROMPT_COMMAND="pwd > /tmp/whereami"

# autocd
shopt -s autocd

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
