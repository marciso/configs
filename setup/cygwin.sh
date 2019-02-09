#!/bin/bash

dst_dir=${HOME:-~}

#setup-x86_64.exe -q --wait -P wget,tar,qawk,bzip2,subversion,vim,git,rsync,curl,python2,python3,bc,tmux,lynx

# apt-cyg is an alternative package manager for cygwinn
lynx -source http://rawgit.com/transcode-open/apt-cyg/master/apt-cyg > ${dst_dir}/bin/apt-cyg

chmod a+x ${dst_dir}/bin/apt-cyg

# gentoo-prefix on cygwin needs proper implemtation of fork()
# https://wiki.gentoo.org/wiki/Prefix/Cygwin
curl https://dev.gentoo.org/~haubi/cygwin-gentoo/x86_64/cygwin-2.11.2-gentoo-r0/cygwin1.dll > ${dst_dir}/bin/cygwin1.dll

chmod a+x ${dst_dir}/bin/cygwin1.dll

s=$(date +%s)
rsync -var /usr/bin/cygwin1.dll /usr/bin/cygwin1.dll.${s}.bak
rsync -var ${dst_dir}/bin/cygwin1.dll /usr/bin/

# enable proper fork implementaion
mkdir -p --mode=a=rwxt /var/run/cygfork

