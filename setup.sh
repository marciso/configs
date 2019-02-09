#!/,bin/bash

die() { echo "ERROR: $*" ; exit 1; }

which rsync || die "rsync needed" # could use simple cp
which curl || die "curl needed" # could use wget
which vim || die "vim needed"
which git || die "git needed"

src_dir=$(dirname "$(readlink -f "$0")")
dst_dir=${HOME:-~}

test -n "$src_dir" || die "Could not locate current directory"

rsync -vari --exclude=.git --exclude=setup.sh --exclude=README.md ${src_dir}/.* ${dst_dir}/

mkdir -p ${dst_dir}/.vim/bundle/
git clone https://github.com/VundleVim/Vundle.vim.git ${dst_dir}/.vim/bundle/Vundle.vim

vim +PluginInstall +qall

curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh > ${dst_dir}/.git-prompt.sh

mkdir ${dst_dir}/.zsh/
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${dst_dir}/.zsh/zsh-syntax-highlighting

# python is needed in a zsh, and vim
which python || die "Please install python"
which tmux || die "Please install tmux"

