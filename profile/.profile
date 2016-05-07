export PATH=~/.localbin:$PATH
export EDITOR=nvim

export PAGER=less
export BROWSER=firefox
#export MOZ_USE_OMTC=1

export LANG="en_US.utf8"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export PATH="${PATH}:/home/delusional/.localbin"
export PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"
export M2_HOME="/opt/maven"

export BSPWM_STATE="$XDG_DATA_HOME/bspwm.state"

export SXHKD_SHELL=/bin/bash

export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel"

export QEMU_AUDIO_DRV=pa

##SSH agent
eval $(keychain --eval --agents ssh -Q --quiet id_ecdsa)

#systemd
systemctl --user import-environment PATH
systemctl --user import-environment HOME
systemctl --user import-environment XDG_CONFIG_HOME
systemctl --user import-environment XDG_DATA_HOME
systemctl --user import-environment XDG_CACHE_HOME
