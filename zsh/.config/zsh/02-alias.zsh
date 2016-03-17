alias cd..='cd ..'

alias mk='mkdir -p'
alias mkdir='mkdir -p'

alias cls='clear'

alias l='ls -Xp --color=auto'
alias ls='ls -Xp --color=auto'

alias open='xdg-open'

# Git
alias g='git'
alias ga='git add'
alias gst='git status'
alias gl='git pull'
alias gup='git fetch && git rebase'
alias gp='git push'
alias gd='git diff | mate'
alias gdv='git diff -w "$@" | vim -R -'
alias gc='git commit -m'
alias gca='git commit -v -a'
alias gch='git checkout'
alias gb='git branch'
alias gba='git branch -a'
alias gcount='git shortlog -sn'
alias gcp='git cherry-pick'

alias vim='nvim'
