alias copycb="xclip -selection clipboard"
alias o="xdg-open"
function f { _handle_file `find . | fzf`; }

#bind dark magic ahead
bind -x '"\200":"_handle_file `ls -a | fzf`"' #\200 macro for local directory fuzzy finder
bind '"\C-o":"\200\C-m"' # set C-0 to run \200 and then update the PS1 with C-m

bind -x '"\201":"f"'
bind '"\C-f":"\201\C-m"'

function _handle_file {
    [[ -d $1 ]] && cd $1
    [[ -f $1 ]] && xdg-open $1
    echo ""
}

function fastmount {
	devname=$(basename $1)
	sudo mkdir -p /mnt/$devname
	sudo mount /dev/$devname /mnt/$devname
}

function sshmount {
	sudo mkdir -p /mnt/ssh_$1
	sudo sshfs  root@$1:/ /mnt/ssh_$1
}