#!/bin/bash

die() { echo "ERROR: $*" ; exit 1; }

which rsync || die "rsync needed" # could use simple cp
which curl || die "curl needed" # could use wget
which vim || die "vim needed"
which git || die "git needed"
# vim needs pynvim, and that is why we need pip
which pip || die "pip needed"
# YouCompleteMe needs cmake g++ python
which cmake || die "cmake needed"
which g++ || die "g++ needed"
which python || die "python needed"
which svn || die "svn (subversion) needed" # for setting up gdb pretty printers


src_dir=$(cd $(dirname "$(readlink -f "$0")") && git rev-parse --show-toplevel)
dst_dir=${HOME:-~}

test -n "$src_dir" || die "Could not locate directory with configs"

rsync -vari --exclude=.git/ --exclude=.gitignore --exclude=setup/ --exclude=README.md ${src_dir}/.* ${dst_dir}/

## VIM

mkdir -p ${dst_dir}/.vim/bundle/
git clone https://github.com/VundleVim/Vundle.vim.git ${dst_dir}/.vim/bundle/Vundle.vim

pip install --user pynvim

mkdir -p ${dst_dir}/.vim/spell/
vim +PluginInstall +qall

## ZSH

curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh > ${dst_dir}/.git-prompt.sh

mkdir ${dst_dir}/.zsh/
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${dst_dir}/.zsh/zsh-syntax-highlighting

## TMUX
mkdir -p ${dst_dir}/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm ${dst_dir}/.tmux/plugins/tpm

${dst_dir}/.tmux/plugins/tpm/bin/install_plugins

## GDB
mkdir -p ${dst_dir}/.gdb/stlprettyprinter/
svn co svn://gcc.gnu.org/svn/gcc/trunk/libstdc++-v3/python ${dst_dir}/.gdb/stlprettyprinter

curl http://www.yolinux.com/TUTORIALS/src/dbinit_stl_views-1.03.txt > ${dst_dir}/.gdb/dbinit_stl_views-1.03.txt

### FZF
git clone --depth 1 https://github.com/junegunn/fzf.git ${dst_dir}/.fzf

${dst_dir}/.fzf/install

## VIM - YouCompleteMe

# execute at the end as it take a lot of time (no need to delay other setup)
(cd ${dst_dir}/.vim/bundle/YouCompleteMe ; python3 install.py --clangd-completer --cs-completer )

# python is needed in a zsh, and vim
which python || die "Please install python"
which tmux || die "Please install tmux"
