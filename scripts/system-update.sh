#!/bin/bash

DIR="$( cd "$( dirname "$( readlink -f ${BASH_SOURCE[0]})" )" >/dev/null 2>&1 && pwd )"

for s in $DIR/../scripts/_logger.sh ~/bin/_logger.sh ; do
    test -f $s && source $s && break
done

# update portage and world if needed

test -f ~/Gentoo/startprefix && G=~/Gentoo
test -f ~/gentoo/startprefix && G=~/gentoo

source $G/etc/profile;

#stamp="$G/usr/portage/metadata/timestamp.x"
#test -f "$stamp" && rm -v "$stamp"
command -v revdep-rebuild >/dev/null 2>&1 || die "Missing revdep-rebuild: emerge app-portage/gentoolkit"
command -v eix-sync >/dev/null 2>&1 || die "Missing eix-sync: emerge app-portage/eix"
#command -v eclean >/dev/null 2>&1 || die "Missing eclean: emerge app-portage/gentoolkit"

run_log eix-sync -v &&
run_log emerge -v --newuse --update --deep --with-bdeps=y --quiet-build --keep-going --backtrack=100 --autounmask-keep-masks=y @world &&
run_log emerge --depclean &&
run_log revdep-rebuild -v &&
run_log emerge -v --quiet-build @preserved-rebuild &&
run_log eclean -v --deep distfiles &&

exit 0
