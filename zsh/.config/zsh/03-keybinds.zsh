# Lets kick this shit into vi mode
bindkey -v
export KEYTIMEOUT=1

# backspace and ^h working even after
# returning from command mode
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char

bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line
bindkey "\e[5~" beginning-of-history
bindkey "\e[6~" end-of-history
bindkey "\e[3~" delete-char
bindkey "\e[2~" quoted-insert
bindkey "\e[5C" forward-word
bindkey "\eOc" emacs-forward-word
bindkey "\e[5D" backward-word
bindkey "\eOd" emacs-backward-word
bindkey "\e\e[C" forward-word
bindkey "\e\e[D" backward-word
# for rxvt
bindkey "\e[8~" end-of-line
bindkey "\e[7~" beginning-of-line
# for non RH/Debian xterm, can't hurt for RH/Debian xterm
bindkey "\eOH" beginning-of-line
bindkey "\eOF" end-of-line
# for freebsd console
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line
bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward

# ctrl-r starts searching history backward
#bindkey '^R' history-incremental-search-backward

bindkey '^F' vi-forward-word

autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd "^V" edit-command-line
bindkey -M viins "^V" edit-command-line

bindkey -M vicmd "ga" what-cursor-position
bindkey -M vicmd "g~" vi-oper-swap-case
bindkey -M vicmd "di" delete-in
bindkey -M vicmd "ci" change-in
bindkey -M vicmd "da" delete-around
bindkey -M vicmd "ca" delete-around

bindkey -M vicmd "^M" accept-line
bindkey -M vicmd "1"-"9" digit-argument

bindkey -M vicmd "=" list-choices
bindkey -M vicmd "^D" list-choices

bindkey -M vicmd  ":"  _complete_help 
bindkey -M vicmd   ";" _read_comp

bindkey -M viins "^U" kill-line
