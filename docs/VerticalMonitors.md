
# Grub / Kernel loading


Modify `/etc/default/grub`; add `fbcon=rotate:3`
```
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash fbcon=rotate:3"
GRUB_CMDLINE_LINUX="fbcon=rotate:3"
```

You may also need to add `video=efifb` to force Grub's framebuffer.

Also useful:
```
GRUB_GFXMODE=1440x2560x24
```

## Rotate param
- 0 - normal
- 1 - rotate left
- 2 - upside down
- 3 - rotate right

### Trying

```
echo 3 > /sys/class/graphics/fbcon/rotate_all
```

# LightDM

Modify `/etc/lightdm/ligthdm.conf`

```
[Seat:*]
display-setup-script=/etc/lightdm/rotate-screens.sh
```

Where `/etc/lightdm/rotate-screens.sh`

```
# try xrandr -q to get the current setting

xrandr --output DisplayPort-3 --rotate left
xrandr --output DisplayPort-4 --rotate left
xrandr --output DisplayPort-5 --rotate right
```

Remember to restart the service:

```
# systemctl status lightdm
systemctl restart lightdm  # will close your current X11 session
```

## Configs
LightDM configuration is provided by the following files:
```
/usr/share/lightdm/lightdm.conf.d/*.conf
/etc/lightdm/lightdm.conf.d/*.conf
/etc/lightdm/lightdm.conf
```

## Logfiles
* `/var/log/lightdm/lightdm.log`
* `/var/log/lightdm/seat*.log`

Note: some alternatives like `[SeatDetaults]` (instead of `[Seat:*]`) or `greeter-setup-script` did not work.

## Did not work

 * Some people suggested copying `~/.config/monitors.xml` into `/var/lib/lightdm/.config/monitors.xml` but it did not seem to work
 * Adding `/etc/X11/Xsession.d/45-marcin_xrandr-settings` with the same content as `/etc/lightdm/rotate-screens.sh` did not make difference but this is probably because Window Manager applies users settings.
 
## Background & Greeter
LightDM does not configure the look of greeters; to do this configure the appropriate greeter.
For LightDM GTK+ greeter edit `/etc/lightdm/lightdm-gtk-greeter.conf`
```
background=/usr/share/backgrounds/gnome/SeaSunset.jpg
```

## More info
- Ubuntu doc: https://wiki.ubuntu.com/LightDM
- Config with comments: https://github.com/Canonical/lightdm/blob/master/data/lightdm.conf
