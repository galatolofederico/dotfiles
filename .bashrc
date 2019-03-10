# tmux
[[ $- != *i* ]] && return
[[ -z "$TMUX" && "$TERM" != "linux" ]] && exec tmux

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# load aliases
[ -f ~/.bash_aliases ] && source ~/.bash_aliases

# env variables
export EDITOR=vim

# autocd
shopt -s autocd