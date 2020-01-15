#!/bin/bash

DIR="$( cd "$( dirname "$( readlink -f ${BASH_SOURCE[0]})" )" >/dev/null 2>&1 && pwd )"

for s in $DIR/../scripts/_logger.sh ~/bin/_logger.sh ; do
    test -f $s && source $s && break
done

verbose=1

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

rsync_opts="-varic --exclude=.git/ --exclude=.gitignore --exclude=setup/ --exclude=README.md"

echo "Calculating difference in dot files:"
files_to_update=$(rsync --dry-run $rsync_opts --filter=":- ${src_dir}/.gitignore" ${src_dir}/.* ${dst_dir}/ | grep '^>fc' | awk '{print $2}')
if [[ -n "$files_to_update" ]] ; then
    for d in $files_to_update ; do
        echo "diff --color=auto -uNa ${dst_dir}/${d} ${src_dir}/${d}"
        diff --color=auto -uNa ${dst_dir}/${d} ${src_dir}/${d}
    done
    echo
    echo "${yellow}Apply the changes above? <Ctrl-C> or <Enter>${normal}"
    read
else
    echo "Dot files did not change"
fi

run_log rsync $rsync_opts --filter=":- ${src_dir}/.gitignore" ${src_dir}/.* ${dst_dir}/

## VIM

run_log mkdir -p ${dst_dir}/.vim/bundle/
run_log git clone https://github.com/VundleVim/Vundle.vim.git ${dst_dir}/.vim/bundle/Vundle.vim

run_log pip install --user pynvim

run_log mkdir -p ${dst_dir}/.vim/spell/
run_log vim +PluginUpdate +qall
#run_log vim +PluginInstall +qall

## ZSH

run_log curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -o ${dst_dir}/.git-prompt.sh

# run_log mkdir ${dst_dir}/.zsh/
# install zsh-syntax-highlighting by zplug
#git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${dst_dir}/.zsh/zsh-syntax-highlighting

## zplug (ZSH plugin manager)
# by default zplug will use ~/.zplug as the home dir; this can be overriden by $ZPLUG_HOME
run_log mkdir ${dst_dir}/.zplug
run_log git clone https://github.com/zplug/zplug ${dst_dir}/.zplug

## TMUX
run_log mkdir -p ${dst_dir}/.tmux/plugins
run_log git clone https://github.com/tmux-plugins/tpm ${dst_dir}/.tmux/plugins/tpm

run_log ${dst_dir}/.tmux/plugins/tpm/bin/install_plugins

## GDB
run_log mkdir -p ${dst_dir}/.gdb/stlprettyprinter/
run_log svn co svn://gcc.gnu.org/svn/gcc/trunk/libstdc++-v3/python ${dst_dir}/.gdb/stlprettyprinter

run_log curl http://www.yolinux.com/TUTORIALS/src/dbinit_stl_views-1.03.txt > ${dst_dir}/.gdb/dbinit_stl_views-1.03.txt

## FZF
run_log git clone --depth 1 https://github.com/junegunn/fzf.git ${dst_dir}/.fzf

run_log ${dst_dir}/.fzf/install

## forgit (https://github.com/wfxr/forgit) will be installed by zplug

## VIM - YouCompleteMe

# execute at the end as it take a lot of time (no need to delay other setup)
(cd ${dst_dir}/.vim/bundle/YouCompleteMe ; run_log python3 install.py --clangd-completer --cs-completer )

# python is needed in a zsh, and vim
which python || die "Please install python"
which tmux || die "Please install tmux"
