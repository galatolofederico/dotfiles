function show_help {
    echo -e "Usage: ./deploy_dotfiles.sh [-f] [-h]\n-h\tShow help\n-f\tBlindly copy all files"
}

FORCE=0
while getopts "h?f?:" opt; do
    case "$opt" in
    h|\?)
        show_help
        exit 0
        ;;
    f)  FORCE=1
        ;;
    esac
done

shift $((OPTIND-1))
[ "${1:-}" = "--" ] && shift

for file in $(find . -type f -not -path "./.git/*" -not -path "./README.md" -not -path "./LICENSE" -not -path "./deploy_dotfiles.sh" -not -path "./backup_old_dotfiles.sh" ); do
    abs_file=$(echo  $file | cut -c3-)
    dest_dir=$(dirname ~/$abs_file)
    mkdir -p -- $dest_dir
    diff --color ./$abs_file ~/$abs_file
    fdiff=$?
    if [ "$fdiff" -gt "0" ]; then
        printf "Overwrite ~/${abs_file}? (y/n)"
        read -n1 ans
        printf "\n"
        if [ "$FORCE" -gt "0" ] || [ "$ans" == "y" ]; then
            cp ./$abs_file ~/$abs_file
        fi
    fi
done
