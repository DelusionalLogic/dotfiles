export EDITOR=vim
export PAGER=less
export BROWSER=firefox
export MOZ_USE_OMTC=1

export LANG="en_US.utf8"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export PATH="${PATH}:/home/delusional/.localbin"
export M2_HOME="/opt/maven"

export BSPWM_TREE="$XDG_DATA_HOME/bspwm.tree"
export BSPWM_HISTORY="$XDG_DATA_HOME/bspwm.history"
export BSPWM_STACK="$XDG_DATA_HOME/bspwm.stack"
export SXHKD_SHELL=/bin/bash

export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswong.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel"

export QEMU_AUDIO_DRV=pa

##SSH agent
eval $(keychain --eval --agents ssh -Q --quiet id_ecdsa)
