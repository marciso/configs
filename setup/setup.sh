#!/bin/bash

readlink=readlink
[[ "$(uname -s)" = "Darwin" ]] && readlink=greadlink # brew install coreutils for greadlink

DIR="$( cd "$( dirname "$( $readlink -f ${BASH_SOURCE[0]})" )" >/dev/null 2>&1 && pwd )"

export MS_EXTENDED_VIMRC=1

source $DIR/setup_basic.sh
