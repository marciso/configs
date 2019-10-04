
source ~/bin/_logger.sh

HOST=${1}

test -n "$HOST" || die "Specify host to copy to"

declare -a files
files=(
    ~/gentoo/
    ~/bin/
    ~/.bash_profile
    ~/.bash_logout
    ~/.bashrc
    ~/.tmux.conf
    ~/.vimrc
    ~/.vim/
    ~/.gitconfig
    ~/.dircolors
    ~/.dircolors.small
    ~/.flake8
    ~/.gdbinit
    ~/.git-prompt.sh
    ~/.ssh/config
    ~/.zlogin
    ~/.zprofile
    ~/.zsh
    ~/.zshenv
    ~/.zshrc
    )

for f in ${files[@]} ; do
    echo rsync -varPi ~/gentoo/ $HOST:~/gentoo/
done
