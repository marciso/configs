#!/bin/bash -x

source ~/bin/_logger.sh

HOST=${1}
HOST_DIR=${HOST:+:}${2}${2:+/}

echo dest: $HOST$HOST_DIR

declare -a files
files=(
    #gentoo/
    bin/
    .bash_profile
    .bash_logout
    .bashrc
    .tmux.conf
    .vimrc
    .vim/
    .gitconfig
    .dircolors
    .dircolors.small
    .flake8
    .gdbinit
    .git-prompt.sh
    .ssh/config
    .zlogin
    .zprofile
    .zsh/
    .zshenv
    .zshrc
    .i3status.conf
    .config/i3/config
    )


pushd $HOME
for f in ${files[@]} ; do
    run_log rsync -varPi "$f" "${HOST}${HOST_DIR}${f}"
done
popd
