#!/bin/bash

if [[ -x /opt/local/bin/port ]] ; then
    sudo port selfupdate
    sudo port upgrade outdated
fi

if [[ -x /usr/local/bin/brew ]] ; then
    brew update
    brew upgrade
fi
