# .zprofile is sourced once, at login (after .zlogin, before .zshrc)
# It is basically the same as .zlogin except that it's sourced directly before
# .zshrc is sourced (instead of directly after it). According to the zsh documentation,
# ".zprofile is meant as an alternative to `.zlogin' for ksh fans; the two are not intended
# to be used together, although this could certainly be done if desired."

OS_PATH=$PATH

# bring gentoo prefix profile as the primary env
test -f $HOME/gentoo/etc/profile && source $HOME/gentoo/etc/profile

GENTOO_PATH=$PATH

export PATH=$GENTOO_PATH:$OS_PATH:$HOME/bin

