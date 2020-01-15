#!/bin/bash

DIR="$( cd "$( dirname "$( readlink -f ${BASH_SOURCE[0]})" )" >/dev/null 2>&1 && pwd )"

for s in $DIR/../scripts/_logger.sh ~/bin/_logger.sh ; do
    test -f $s && source $s && break
done

verbose=1

uid=$(id -u)

command -v fail2ban-client >/dev/null 2>&1 || die "Is fail2ban installed?"
test $uid -eq 0 || die "Run this as root"

echo Fail2Ban version: $(fail2ban-client version)
echo Client sent ping, $(fail2ban-client ping)
run_log fail2ban-client get dbfile
run_log fail2ban-client status

for jail in $(fail2ban-client status | grep 'Jail list:' | sed -e 's/.*Jail list://' | tr ',' ' ') ; do
    echo
    run_log fail2ban-client status $jail
done

echo
echo "Also try:                 iptables -L"
echo "To release IP from jail:  fail2ban-client unban <IP>"
