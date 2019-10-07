
# This file is ansible managed and will be overwritten
# .gdbinit

set print pretty on
set print symbol-filename on
set print array on
set print null-stop on
set print sevenbit-strings on
set print union on
set print demangle on
set print object on
set print static-members off
set print vtbl on

# disable clumsy paging (use terminal scrollback buffer instead)
set height 0

# for freertos POSIX simulation:
handle SIGUSR1 nostop noignore noprint
handle SIG34 nostop noignore noprint

#set prompt [31m(gdb) [m


# log gdb output (defaults to gdb.txt in current directory)
#set logging on

set history save
set history filename ~/.gdb_history
set history size 10000

set confirm off

define bta
thread apply all backtrace
end
document bta
Alias for 'thread apply all backtrace'
end

define btaf
thread apply all backtrace full
end
document btaf
Alias for 'thread apply all backtrace full'
end

define lon
set scheduler-locking on
end
document lon
Alias for 'set scheduler-locking on'
end

define loff
set scheduler-locking off
end
document loff
Alias for 'set scheduler-locking off'
end

#  To print the classes in the old style, use the /r (raw) switch in the print command (i.e., print /r foo). This will
#  print the classes as if the Python pretty-printers were not loaded
set auto-load safe-path /

python
import sys
import os
sys.path.insert(0, os.getenv('HOME', default='~') + '/.gdb/stlprettyprinter')
from libstdcxx.v6.printers import register_libstdcxx_printers
register_libstdcxx_printers(None)
end

source ~/.gdb/dbinit_stl_views-1.03.txt
