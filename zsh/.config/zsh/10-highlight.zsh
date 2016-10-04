#syntax highlight

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

# STYLES
# Aliases and functions
ZSH_HIGHLIGHT_STYLES[alias]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=blue,bold'

# Commands and builtins
ZSH_HIGHLIGHT_STYLES[command]="fg=blue"
ZSH_HIGHLIGHT_STYLES[hashed-command]="fg=blue"
ZSH_HIGHLIGHT_STYLES[builtin]="fg=blue"

# Paths
ZSH_HIGHLIGHT_STYLES[path]='fg=white'

# Globbing
ZSH_HIGHLIGHT_STYLES[globbing]='fg=yellow,bold'

# Options and arguments
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=red'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=red'

ZSH_HIGHLIGHT_STYLES[back-quoted-argument]="fg=green"
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]="fg=green"
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]="fg=green"
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]="fg=green"
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]="fg=green"

# PATTERNS
# rm -rf
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=red,bold')

# Sudo
ZSH_HIGHLIGHT_PATTERNS+=('sudo ' 'fg=red')

#Autosuggestion
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=white,bold'
