# .zprofile is sourced once, at login (after .zlogin, before .zshrc)
# It is basically the same as .zlogin except that it's sourced directly before
# .zshrc is sourced (instead of directly after it). According to the zsh documentation,
# ".zprofile is meant as an alternative to `.zlogin' for ksh fans; the two are not intended
# to be used together, although this could certainly be done if desired."

test -d /opt/local/bin && export PATH=/opt/local/bin:$PATH
test -d /opt/local/sbin && export PATH=/opt/local/sbin:$PATH
test -d /opt/X11/bin && export PATH=/opt/X11/bin:$PATH
test -d /usr/local/bin && export PATH=/usr/local/bin:$PATH
test -d /usr/local/sbin && export PATH=/usr/local/sbin:$PATH


# bring gentoo prefix profile as the primary env
OS_PATH=$PATH
if [[ -f $HOME/gentoo/zsh/etc/zprofile ]] ; then
    source $HOME/gentoo/zsh/etc/zprofile
    GENTOO_PATH=$PATH
    export PATH=$GENTOO_PATH:$OS_PATH:$HOME/bin
elif [[ -f $HOME/gentoo/etc/profile ]] ; then
    source $HOME/gentoo/etc/profile
    GENTOO_PATH=$PATH
    export PATH=$GENTOO_PATH:$OS_PATH:$HOME/bin
fi

#export XDG_DATA_DIRS=/usr/share/unity:/usr/local/share:/usr/share:/var/lib/snapd/desktop:$XDG_DATA_DIRS

if [ -z "$SSH_AUTH_SOCK" ] ; then
  eval `ssh-agent -s`
  ssh-add
fi
trap 'test -n "$SSH_AUTH_SOCK" && eval `/usr/bin/ssh-agent -k`' 0

#source $HOME/gentoo/startprefix
