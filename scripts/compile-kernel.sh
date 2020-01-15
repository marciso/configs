#!/bin/bash

DIR="$( cd "$( dirname "$( readlink -f ${BASH_SOURCE[0]})" )" >/dev/null 2>&1 && pwd )"

for s in $DIR/../scripts/_logger.sh ~/bin/_logger.sh ; do
    test -f $s && source $s && break
done

verbose=1

set -e

uid=$(id -u)
test $uid -eq 0 || die "Run this as root"

# make sure kernel is correct
run_log eselect kernel list
echo "Make sure the correct kernel will be build"
echo "Run ${green} eselect kernel set NUMBER ${normal} to change"
echo "Press <Ctrl-C> or <Enter>"
read
eselect kernel show
# copy old config

# backup
#test -f /usr/src/linux/.config && cp -v /usr/src/linux/.config ~/kernel-config-$(make -s -C /usr/src/linux kernelversion)
#zcat /proc/config.gz > ~/kernel-config-`uname -r`

log "zcat /proc/config.gz > /usr/src/linux/.config"
zcat /proc/config.gz > /usr/src/linux/.config

run_log cd /usr/src/linux
# convert old config into new, alternative target: olddefconfig
run_log make syncconfig
#make olddefconfig

# NOTE: https://wiki.gentoo.org/wiki/Kernel/Upgrade
# see how to install portage hook to build kernel on emerge

run_log genkernel all

# make modules_prepare will prepare binary kernel modules to be built
# it is not needed if the entire kernel is built

# rebuild emerges with new kernel
run_log emerge -va @module-rebuild

run_log grub-mkconfig -o /boot/grub/grub.cfg
