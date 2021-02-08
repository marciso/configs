#!/bin/bash

set -e

#normal=$(tput sgr0)                      # normal text
normal=$'\e[0m'                           # (works better sometimes)
bold=$(tput bold)                         # make colors bold/bright
red="$bold$(tput setaf 1)"                # bright red text
green=$(tput setaf 2)                     # dim green text
fawn=$(tput setaf 3); beige="$fawn"       # dark yellow text
yellow="$bold$fawn"                       # bright yellow text
darkblue=$(tput setaf 4)                  # dim blue text
blue="$bold$darkblue"                     # bright blue text
purple=$(tput setaf 5); magenta="$purple" # magenta text
pink="$bold$purple"                       # bright magenta text
darkcyan=$(tput setaf 6)                  # dim cyan text
cyan="$bold$darkcyan"                     # bright cyan text
gray=$(tput setaf 7)                      # dim white text
darkgray="$bold"$(tput setaf 0)           # bold black = dark gray text
white="$bold$gray"                        # bright white text

log() { echo "${yellow}*** $(date +%T.%N): $@${normal}"; }
err() { echo "${red}*** $(date +%T.%N): $@${normal}"; }
die() { err "$@"; exit 1; }

dry_run=
verbose=1
run_log() { ((verbose)) && log "$@"; ${dry_run:+echo} eval "$@"; }

force=0
force_download=0

should_use_rh_devtoolset9=0

version=11.0.0
url="https://github.com/llvm/llvm-project/releases/download/llvmorg-${version}"

top_dir=$HOME/external/llvm

clang=clang-${version}
llvm=llvm-${version}
extra_tools=clang-tools-extra-${version}

clang_tar=${clang}.src.tar.xz
llvm_tar=${llvm}.src.tar.xz
extra_tools_tar=${extra_tools}.src.tar.xz

cmake=cmake3
make_target=clangd
make_args=-j10

download() {
    local url="$1"
    local dest="$2"

    run_log curl -L -o "$dest" "$url"
}

download_if_needed() {
    local url="$1"
    local dest="$2"

    local dest_exists=0
    test -f "$dest" && dest_exists=1

    ((!dest_exists || force_download)) && download "$url" "$dest"
}

download_if_needed_from() {
    download_if_needed "$1/$2" "$2"
}

unpack_as() {
    local tarball="$1"
    local dest_dir="$2"

    mkdir -p "$dest_dir" && run_log tar xf "$tarball" -C "$dest_dir" --strip-components 1
}

unpack_as_if_needed () {
    local dest_dir="$2"

    test -d "$dest_dir" || unpack_as "$1" "$2"
}


((should_use_rh_devtoolset9)) && test -f /opt/rh/devtoolset-9/enable && source /opt/rh/devtoolset-9/enable

download_if_needed_from ${url} ${llvm_tar}
download_if_needed_from ${url} ${clang_tar}
download_if_needed_from ${url} ${extra_tools_tar}

((force)) && test -d "$top_dir" && run_log rm -rf --one-file-system --preserve-root "$top_dir" ;

unpack_as_if_needed "$llvm_tar" "$top_dir"
unpack_as_if_needed "$clang_tar" "$top_dir/tools/clang"
unpack_as_if_needed "$extra_tools_tar" "$top_dir/tools/clang/tools/extra"

test -f $top_dir/build/bin/clangd || {
    mkdir "$top_dir/build" ;
    ( pushd "$top_dir/build" && run_log $cmake -G 'Unix\ Makefiles' .. && run_log make $make_args $make_target ) ;
}

echo
echo If you want to override YCM:
echo   cp -av $top_dir/build/bin/clangd $HOME/.vim/bundle/YouCompleteMe/third_party/ycmd/third_party/clangd/output/bin/clangd
echo
echo NOTE: first compile YCM:
echo   cd $HOME/.vim/bundle/YouCompleteMe/ \&\& python install.py --clangd-completer
echo

