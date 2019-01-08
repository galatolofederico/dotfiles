for file in $(find . -type f -not -path "./.git/*" -not -path "./README.md" -not -path "./LICENSE" -no -path "deploy_dotfiles.sh" -no -path "backup_old_dotfiles.sh" ); do
    abs_file=$(echo  $file | cut -c3-)
    dest_dir=$(dirname ~/$abs_file)
    mkdir -p -- $dest_dir
    cp ./$abs_file ~/$abs_file
done