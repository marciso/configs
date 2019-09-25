#!/bin/bash

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

dry_run=
log() { echo "${yellow}*** $(date +%T.%N): $@${normal}"; }
run_log() { log "$@"; ${dry_run:+echo} eval "$@"; }

# update portage and world if needed

G=~/gentoo

source $G/etc/profile;

#stamp="$G/usr/portage/metadata/timestamp.x"
#test -f "$stamp" && rm -v "$stamp"

run_log eix-sync -v &&
run_log emerge -v --newuse --update --deep --with-bdeps=y --quiet-build @world &&
run_log emerge --depclean &&
run_log revdep-rebuild -v &&
run_log emerge -v --quiet-build @preserved-rebuild &&
run_log eclean -v --deep distfiles &&

exit 0
