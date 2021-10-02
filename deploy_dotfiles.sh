#!/bin/bash


RESOURCES=(
bin
.config/favourites
.config/fontconfig
.config/gtk-3.0
.config/xfce4
.bash_aliases
.bash_completions
.bash_functions
.bash_profile
.bashrc
.compton.conf
.conkyrc
.gtkrc-2.0
.vimrc
.xinitrc
)


TARGET=~
if [ "$#" -eq 1 ]; then
    TARGET=$1
fi
[ ! -d ./backups ] && mkdir ./backups
BACKUP="./backups/$(date '+%s')"

echo "[!] Using $TARGET as target folder"
echo "[!] Using $BACKUP as backup folder (if needed)"

[ ! -d "$TARGET/.config" ] && mkdir "$TARGET/.config"
for resource in "${RESOURCES[@]}"; do
    if [ -f "$TARGET/$resource" ] || [ -d "$TARGET/$resource" ]; then
        [ ! -d "$BACKUP" ] && mkdir "$BACKUP"
        [ ! -d "$BACKUP/.config" ] && mkdir "$BACKUP/.config"
        
        cp -r "$TARGET/$resource" "$BACKUP/$resource"
        echo "[*] Saved backup for '$TARGET/$resource'"
        del="$TARGET/$resource"
        rm -rf "${del:?}"
        echo "[*] Deleted '$del'"
    fi
    ln -s "$(pwd)/$resource" "$TARGET/$resource"
    echo "[*] Created symlink to $TARGET/$resource"
done


