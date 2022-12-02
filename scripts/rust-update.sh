#!/bin/bash

readlink=readlink
DIR="$( cd "$( dirname "$( $readlink -f ${BASH_SOURCE[0]})" )" >/dev/null 2>&1 && pwd )"

for s in $DIR/../scripts/_logger.sh ~/bin/_logger.sh ; do
    test -f $s && source $s && break
done

verbose=1

run_log rustup self update
run_log rustup update

run_log rustup --version
run_log cargo --version
