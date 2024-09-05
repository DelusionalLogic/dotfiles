export GENCOMPL_PY=python3

if ! [[ -d ~/.config/zgenom ]]; then
	git clone "https://github.com/jandamm/zgenom.git" ~/.config/zgenom
fi
source ~/.config/zgenom/zgenom.zsh

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

# source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"
source <(fzf --zsh)

# if the init script doesn't exist
if ! zgenom saved; then
	zgenom load "zsh-users/zsh-autosuggestions"
	zgenom load "supercrabtree/k"
	zgenom load "djui/alias-tips"
	zgenom load "RobSis/zsh-completion-generator"
	zgenom load "zsh-users/zsh-syntax-highlighting"

	zgenom save
fi

# eval $( dircolors -b $XDG_CONFIG_HOME/zsh/LS_COLORS/LS_COLORS )
export LS_COLORS

for file in $HOME/.config/zsh/*.zsh; do
	source "$file"
done

GPG_TTY=$(tty)
export GPG_TTY
