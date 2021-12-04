# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# load aliases
[ -f ~/.bash_aliases ] && source ~/.bash_aliases
# load functions
[ -f ~/.bash_functions ] && source ~/.bash_functions
# load private aliases
[ -f ~/.private_aliases ] && source ~/.private_aliases
# load completions
[ -f ~/.bash_completions ] && source ~/.bash_completions
# load custom stuff
[ -f ~/.bash_custom ] && source ~/.bash_custom

# env variables
export EDITOR=vim
export TERMINAL=st
export PATH=$PATH:$HOME/bin:$HOME/.local/bin:$HOME/.local/opt/pso
export TEMPLATES_DIR=~/.config/templates/

# autocd
shopt -s autocd

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# ssh-agent
eval $(ssh-agent) > /dev/null

if [[ "$(tty)" = "/dev/tty1" ]]; then
    pgrep openbox || startx
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/federico/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/federico/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/federico/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/federico/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

