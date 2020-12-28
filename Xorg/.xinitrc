#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

xset +fp /usr/share/fonts/local
xset +fp /home/delusional/.local/share/fonts
xset fp rehash

# Here Xfce is kept as default
session=${1:-bspwm}

case $session in
	awesome           ) exec awesome;;
	bspwm             ) exec bspwm-session;;
	catwm             ) exec catwm;;
	cinnamon          ) exec cinnamon-session;;
	dwm               ) exec dwm;;
	enlightenment     ) exec enlightenment_start;;
	ede               ) exec startede;;
	fluxbox           ) exec startfluxbox;;
	gnome             ) exec gnome-session;;
	gnome-classic     ) exec gnome-session --session=gnome-classic;;
	i3|i3wm           ) exec i3;;
	icewm             ) exec icewm-session;;
	jwm               ) exec jwm;;
	kde               ) exec startkde;;
	mate              ) exec mate-session;;
	monster|monsterwm ) exec monsterwm;;
	notion            ) exec notion;;
	openbox           ) exec openbox-session;;
	unity             ) exec unity;;
	xfce|xfce4        ) exec startxfce4;;
	xmonad            ) exec xmonad;;
	budgie            ) exec budgie-session;;
	kwin              ) exec kwin_x11;;
	# No known session, try to run it as command
	*) exec $1;;
esac
