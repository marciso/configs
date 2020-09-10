#!/bin/sh

host=trade-marcin
user=marcin
domain=TANIUS

pass=$(zenity --password --title="Remote Desktop to $host")
rc=$?
if [ $rc -eq 0 ] ; then
    # USE CTRL+ALT+ENTER to exit the full screen mode
    # --ignore-certificate
    # log-filters is a workaround for spamming log when +async-update selected
    xfreerdp /u:$user /v:$host /d:$domain -wallpaper +home-drive +clipboard /bpp:16 -encryption +compression +fonts /f +dynamic-resolution +multimon \
        +async-update +async-input +async-channels /log-filters:com.freerdp.core.message:OFF /p:$pass
fi
