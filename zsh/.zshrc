fpath=(~/.config/zsh/autocomplete $fpath)

autoload -U colors && colors
autoload -U compinit && compinit
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

#Autojump hook
source /etc/profile.d/autojump.zsh

#Command not found hook
source /usr/share/doc/pkgfile/command-not-found.zsh

#syntax highlight7
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#Autocompletion
source ~/.config/zsh/autosuggestions/zsh-autosuggestions.zsh

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# Import seperate config files
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

for r in $HOME/.config/zsh/*.zsh; do
  if [[ $DEBUG > 0 ]]; then
    echo "zsh: sourcing $r"
  fi
  source $r
done

eval $( dircolors -b $XDG_CONFIG_HOME/zsh/LS_COLORS/LS_COLORS )
export LS_COLORS

GPG_TTY=$(tty)
export GPG_TTY
