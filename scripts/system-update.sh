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

run_log eix-sync -v &&
run_log emerge -v --newuse --update --deep --with-bdeps=y --quiet-build @world &&
run_log emerge --depclean &&
run_log revdep-rebuild -v &&
run_log emerge -v --quiet-build @preserved-rebuild &&
run_log eclean -v --deep distfiles &&

exit 0
