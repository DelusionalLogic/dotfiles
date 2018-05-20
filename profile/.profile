export EDITOR=nvim

export PAGER=less
export BROWSER=firefox
#export MOZ_USE_OMTC=1

export LANG="en_US.UTF-8"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export GOPATH=~/go

export PATH="$PATH:$GOPATH/bin"
export PATH="$(luarocks path --lr-bin):$PATH"
export PATH="$(luarocks-5.1 path --lr-bin):$PATH"
export PATH="$HOME/.localbin:$HOME/.local/bin:${PATH}"

export PKG_CONFIG_PATH="$HOME/.local/share/pkgconfig:${PKG_CONFIG_PATH}"

export LUA_INIT="@$HOME/.localbin/luainit.lua"
# export LUA_PATH="$(luarocks path --lr-path);$(luarocks-5.1 path --lr-path);$LUA_PATH"
# export LUA_CPATH="$(luarocks path --lr-cpath);$(luarocks-5.1 path --lr-cpath);$LUA_CPATH"

export M2_HOME="/opt/maven"

export BSPWM_STATE="$XDG_DATA_HOME/bspwm.state"

export SXHKD_SHELL=/bin/bash

export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel"

export QEMU_AUDIO_DRV=pa

export GEM_HOME=$HOME/.gem

PATH="/home/delusional/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/delusional/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/delusional/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/delusional/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/delusional/perl5"; export PERL_MM_OPT;

##SSH agent
# eval $(keychain --eval --agents ssh -Q --quiet id_ecdsa)
gpg-connect-agent /bye
export SSH_AUTH_SOCK=/run/user/1000/gnupg/S.gpg-agent.ssh

#systemd
systemctl --user import-environment PATH
systemctl --user import-environment HOME
systemctl --user import-environment XDG_CONFIG_HOME
systemctl --user import-environment XDG_DATA_HOME
systemctl --user import-environment XDG_CACHE_HOME
