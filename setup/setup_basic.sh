#!/bin/bash

readlink=readlink
[[ "$(uname -s)" = "Darwin" ]] && readlink=greadlink # brew install coreutils for greadlink

DIR="$( cd "$( dirname "$( $readlink -f ${BASH_SOURCE[0]})" )" >/dev/null 2>&1 && pwd )"

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
which python3 || die "python3 needed"
which svn || die "svn (subversion) needed" # for setting up gdb pretty printers

diff_color_opt="--color=auto"
[[ "$(uname -s)" = "Darwin" ]] && diff_color_opt=


git_clone_or_pull() {
    local url=${1}
    local dir=${2}
    if [[ -d "${dir}" ]] ; then
        rurl=$(cd $dir && git remote get-url $(git remote))
        if [[ "${url}" != "${rurl}" ]] ; then
            err "URLs mismatch in git repo ${dir}: requested: ${url}, previous: ${rurl}. Continuing with the previous!"
        fi
        (run_log cd $dir && run_log git pull)
    else
        # --depth 1: history of 1 commit
        run_log git clone --depth 5 "${url}" "${dir}"
    fi
}

svn_checkout_or_update() {
    local url=${1}
    local dir=${2}
    if [[ -d "${dir}" ]] ; then
        (run_log cd $dir && run_log svn update)
    else
        # --depth 1: history of 1 commit
        run_log svn checkout "${url}" "${dir}"
    fi
}

download_file() {
    local url=${1}
    local fn=${2}
    local tmp=$(mktemp)
    run_log curl "${url}" -o "${tmp}"
    diff ${diff_color_opt} -uNa "${fn}" "${tmp}" || read -p "${pink}Continue? <Ctrl-C> or <Enter>${normal}"
    run_log mv -v "${tmp}" "${fn}"
}


src_dir=$(cd $(dirname "$($readlink -f "$0")") && git rev-parse --show-toplevel)
dst_dir=${HOME:-~}

test -n "$src_dir" || die "Could not locate directory with configs"

rsync_opts="-varic --exclude=.git/ --exclude=.gitignore --exclude=setup/ --exclude=README.md"

files_to_update="
.gdbinit
.vimrc
.zprofile
.zshenv
.zshrc
.gdb/dbinit_stl_views-1.03.txt
scripts/_logger.sh
scripts/check-ssh-ban.sh
scripts/compile-kernel.sh
scripts/generate-tags.sh
scripts/system-update.sh
scripts/term-encodning.sh
"

echo "Calculating difference in dot files:"
for d in $files_to_update ; do
    echo "diff ${diff_color_opt} -uNa ${dst_dir}/${d} ${src_dir}/${d}"
    diff ${diff_color_opt} -uNa ${dst_dir}/${d} ${src_dir}/${d}
    echo
    ANS=
    while [[ -z $ANS ]] ; do
        ANS=n
        read -p "${pink}Apply the changes above? y/[n]${normal}" ANS
        if [[ "$ANS" = "y" ]] ; then
            run_log rsync $rsync_opts ${src_dir}/${d} ${dst_dir}/${d}
        elif [[ "$ANS" != "n" ]] ; then
            err "Answer 'y' or 'n'"
            ANS=
        fi
    done
done

for file in "${dst_dir}/.bashrc" "${dst_dir}/.zshrc" ; do
    log "Patching $file for MS_EXTENDED_VIMRC=$MS_EXTENDED_VIMRC"
    sed -e 's/unset MS_EXTENDED_VIMRC//;s/export MS_EXTENDED_VIMRC=.*//' -i $file
    if [[ -n "$MS_EXTENDED_VIMRC" ]] ; then
        # need to set it
        echo "export MS_EXTENDED_VIMRC=1" >> $file
    else
        echo "unset MS_EXTENDED_VIMRC" >> $file
    fi
done

## VIM

run_log mkdir -p ${dst_dir}/.vim/bundle/
git_clone_or_pull https://github.com/VundleVim/Vundle.vim.git ${dst_dir}/.vim/bundle/Vundle.vim

run_log pip install --user pynvim

run_log mkdir -p ${dst_dir}/.vim/spell/
test -z "$SKIP_VIM_PLUGIN_UPDATE" && run_log vim "+PluginUpdate" "+PluginClean!" "+qall"
#run_log vim +PluginInstall +qall

## ZSH

download_file https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh ${dst_dir}/.git-prompt.sh

# run_log mkdir ${dst_dir}/.zsh/
# install zsh-syntax-highlighting by zplug
#git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${dst_dir}/.zsh/zsh-syntax-highlighting

## zplug (ZSH plugin manager)
# by default zplug will use ~/.zplug as the home dir; this can be overriden by $ZPLUG_HOME
git_clone_or_pull https://github.com/zplug/zplug ${dst_dir}/.zplug

## TMUX
run_log mkdir -p ${dst_dir}/.tmux/plugins
git_clone_or_pull https://github.com/tmux-plugins/tpm ${dst_dir}/.tmux/plugins/tpm

run_log ${dst_dir}/.tmux/plugins/tpm/bin/install_plugins

## GDB
run_log mkdir -p ${dst_dir}/.gdb/stlprettyprinter/
svn_checkout_or_update svn://gcc.gnu.org/svn/gcc/trunk/libstdc++-v3/python ${dst_dir}/.gdb/stlprettyprinter

download_file http://www.yolinux.com/TUTORIALS/src/dbinit_stl_views-1.03.txt ${dst_dir}/.gdb/dbinit_stl_views-1.03.txt

## FZF
git_clone_or_pull https://github.com/junegunn/fzf.git ${dst_dir}/.fzf

run_log ${dst_dir}/.fzf/install --all

## forgit (https://github.com/wfxr/forgit) will be installed by zplug

## VIM - YouCompleteMe

# execute at the end as it take a lot of time (no need to delay other setup)
if [[ -d ${dst_dir}/.vim/bundle/YouCompleteMe ]] ; then
    (cd ${dst_dir}/.vim/bundle/YouCompleteMe ; run_log python3 install.py --clangd-completer --cs-completer)
else
    log "Skipped YouCompleteMe installation"
    test -n "$MS_EXTENDED_VIMRC" && err "YouCompleteMe should have been installed but it is not"
fi

# python is needed in a zsh, and vim
# which python || die "Please install python"
which tmux || err "Please install tmux"
which ctags || err "Please install ctags"
which cscope || err "Please install cscope"
