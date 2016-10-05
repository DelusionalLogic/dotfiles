fpath=(~/.config/zsh/autocomplete $fpath)

autoload -U colors && colors
autoload -U vcs_info && vcs_info

zmodload zsh/complist
zmodload zsh/terminfo

setopt \
  autocd \
  ksh_glob \
  extendedglob \
  prompt_subst \
  inc_append_history

# Completion for alias
setopt completealiases

#zplug plugin manager
source ~/.zplug/init.zsh

#Autojump hook
zplug "/etc/profile.d/autojump.zsh", from:local

#Command not found hook
zplug "/usr/share/doc/pkgfile/command-not-found.zsh", from:local

#Autocompletion
zplug "zsh-users/zsh-autosuggestions"
#source ~/.config/zsh/autosuggestions/zsh-autosuggestions.zsh

#Arcanist
zplug "/usr/share/php/arcanist/resources/shell/bash-completion", from:local

zplug "djui/alias-tips"
zplug "arzzen/calc.plugin.zsh"
zplug "Seinh/git-prune"
zplug "RobSis/zsh-completion-generator"

. /usr/share/fzf/key-bindings.zsh

#Make sure this is last!
zplug "zsh-users/zsh-syntax-highlighting", nice:10

zplug "~/.config/zsh", from:local, nice:11

zplug load

eval $( dircolors -b $XDG_CONFIG_HOME/zsh/LS_COLORS/LS_COLORS )
export LS_COLORS

GPG_TTY=$(tty)
export GPG_TTY

