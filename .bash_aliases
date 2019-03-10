alias copycb="xclip -selection clipboard"
alias o="xdg-open"
function f { _handle_file `find . | fzf`; }

#bind dark magic ahead
bind -x '"\200":"_handle_file `ls -a | fzf`"' #\200 macro for local directory fuzzy finder
bind '"\C-o":"\200\C-m"' # set C-0 to run \200 and then update the PS1 with C-m

bind -x '"\201":"f"'
bind '"\C-f":"\201\C-m"'

bind '"\202":"cd .."'
bind '"\C-h":"\202\C-m"'


bind -x '"\203":_navigate'
bind '"\C-n":"\203\C-m"'

bind -x '"\C-l":ls'

function _navigate {
    while :
    do
        file=$(ls -a | fzf)
        if [ -z $file ] || [ "$file" == "." ]; then
            break
        else
            _handle_file $file
        fi
    done
}

function _handle_file {
    [[ -d $* ]] && cd "$*"
    [[ -f $* ]] && xdg-open "$*"
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