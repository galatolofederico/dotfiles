function fastmount {
    devname=$(basename $1)
    sudo mkdir -p /mnt/$devname
    sudo mount /dev/$devname /mnt/$devname
}

function sshmount {
    sudo mkdir -p /mnt/ssh_$1
    sudo sshfs  root@$1:/ /mnt/ssh_$1
}
