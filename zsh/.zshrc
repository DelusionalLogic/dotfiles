fpath=(~/.config/zsh/autocomplete $fpath)

autoload -U colors && colors
autoload -Uz vcs_info

zmodload zsh/complist
zmodload zsh/terminfo

setopt \
  autocd \
  ksh_glob \
  extendedglob \
  prompt_subst \
  inc_append_history
setopt promptsubst

# Completion for alias
setopt completealiases

#zplug plugin manager
source ~/.zplug/init.zsh

#Autojump hook
zplug "/etc/profile.d", use:"autojump.zsh", from:local

#Command not found hook
# zplug "/usr/share/doc/pkgfile", use:"command-not-found.zsh", from:local

#Autocompletion
zplug "zsh-users/zsh-autosuggestions"

zplug "supercrabtree/k"

#Arcanist
#zplug "/usr/share/php/arcanist/resources/shell", use:"bash-completion", from:local

zplug "djui/alias-tips"
zplug "arzzen/calc.plugin.zsh"
zplug "Seinh/git-prune"
zplug "RobSis/zsh-completion-generator"

zplug "junegunn/fzf-bin", \
    from:gh-r, \
    as:command, \
    rename-to:fzf, \

zplug "/usr/share/fzf", use:"key-bindings.zsh", from:local

#Make sure this is last!
zplug "zsh-users/zsh-syntax-highlighting", defer:2

eval $( dircolors -b $XDG_CONFIG_HOME/zsh/LS_COLORS/LS_COLORS )
export LS_COLORS

zplug "~/.config/zsh", from:local, defer:3

zplug load

GPG_TTY=$(tty)
export GPG_TTY
