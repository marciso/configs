# SSH

1. On Server:
   1. Make sure the server is having `ForwardX11 yes` (`/etc/ssh/sshd_config`)
   1. Install `xauth` on the server (`yum install xauth`)
1. On client:
   1. running X server (X.Org, cygwin: XWin)
      * take a note which screen it runs on (normally: `:0`)
      * you may need to `xhost +` on the server
   1. `export DISPLAY=localhost:0`  # `DISPLAY=:0` does not always work because it assumes using Unix pipes; this does not play well with cygwin and outside it.
   1. `ssh -Y server xclock`  # that shoud be enough
      * Once on the server, the display will be offetted by 10 (can be changed in `/etc/ssh/sshd_config`) and you shoudl see `DISPLAY=localhost:10.0`
      
If you need to jump to another host from the inital server, you will need to setup a tunnel:
`ssh -L 2222:target-machine:22 server`  # sets up a tunnel: `localhost:2222 -> (server) -> target-machine:22`
Now try to connect with `-Y`:
`ssh -Y -p 2222 localhost xclock`


# SUDO

Sometimes this fails:
```
sudo xclock                                                                                                                                                                        15:45:39^1
X11 connection rejected because of wrong authentication.
Error: Can't open display: localhost:10.0
```

Try this:

`export XAUTHORITY=~/.Xauthority ` then `sudo xclock`
