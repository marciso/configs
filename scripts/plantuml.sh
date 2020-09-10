#!/bin/sh
normal=$'\e[0m'                           # (works better sometimes)
red="$bold$(tput setaf 1)"                # bright red text
fawn="$(tput setaf 3)"                    # dark yellow text
yellow="$bold$fawn"                       # bright yellow text

log() { echo "${yellow}*** $(date +%T.%N): $@${normal}"; }
err() { echo "${red}*** $(date +%T.%N): $@${normal}"; }
die() { err "$@"; exit 1; }

JAR=$HOME/plantuml/plantuml.jar

URL=http://sourceforge.net/projects/plantuml/files/plantuml.jar/download
test -f $JAR || die "Please install plantuml into ~/plantuml:\n\tmkdir -p ~/plantuml && cd ~/plantuml\n\tcurl -JLO ${URL}"

#sudo apt install -y graphviz default-jre

java -jar ~/plantuml/plantuml.jar "$@"
