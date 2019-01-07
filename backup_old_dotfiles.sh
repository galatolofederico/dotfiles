if [ $# -eq 0 ]; then
    echo "Usage: ./backup_old_dotfiles.sh <destination_dir>"
    echo "Example: ./backup_old_dotfiles.sh ~/old_dotfiles"
    exit
fi

dest=$1

mkdir -p $dest
for file in $(find . -type f -not -path "./.git/*" -not -path "./README.md" -not -path "./LICENSE" ); do
    abs_file=$(echo  $file | cut -c3-)
    if [ -f ~/$abs_file ]; then
        dest_dir=$(dirname $dest/$abs_file)
        mkdir -p -- $dest_dir
        cp ~/$abs_file $dest/$abs_file
    fi
done