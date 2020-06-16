
# This file is ansible managed and will be overwritten
# .gdbinit

# HINTS:
# fs c - switch on TUI and focus in CMD windows
# fs s - focus to SRC window
# CTRL-x a - toggle TUI
# CTRL-x o - change active window
# CTRL-x s - toggle single key mode:
#   c continue
#   d down
#   f finish
#   n next
#   o nexti. The shortcut letter ‘o’ stands for “step Over”.
#   q exit the SingleKey mode.
#   r run
#   s step
#   i stepi. The shortcut letter ‘i’ stands for “step Into”.
#   u up
#   v info locals
#   w where


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

# trace all commands: the command is displayed as it is executed
set trace-commands on
# use tail -f ~/.gdb_logging
set logging file ~/.gdb_logging
set logging on
# set logging overwrite

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

# python
# import sys
# import os
# sys.path.insert(0, os.getenv('HOME', default='~') + '/.gdb/stlprettyprinter')
# from libstdcxx.v6.printers import register_libstdcxx_printers
# register_libstdcxx_printers(None)
# end

source ~/.gdb/dbinit_stl_views-1.03.txt

# Mono support libraries use a couple of signals internally that confuse gdb, to work around this:
#handle SIGXCPU SIG33 SIG35 SIG36 SIG37 SIG38 SIGPWR nostop noprint

#source ~/.gdb/gdb-dashboard
