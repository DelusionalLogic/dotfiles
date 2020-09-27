# {{{ Title stuffs
precmd() {
	case $TERM in
		rxvt-unicode-256color | screen-256color ) 
			print -Pn "\e]0;%n@%m: %~\a" ;;
	esac
}

function zle-line-init {
	vcs_info
	setprompt
	zle .reset-prompt
}
zle -N zle-line-init

function zle-keymap-select {
	setprompt
	zle .reset-prompt
}
zle -N zle-keymap-select

function ranger-cd {
	tempfile="$(mktemp -t tmp.XXXXXX)"
	/usr/bin/ranger --choosedir="$tempfile" "${@:-$(pwd)}"
	test -f "$tempfile" &&
		if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
			cd -- "$(cat "$tempfile")"
		fi
	rm -f -- "$tempfile"
}
bindkey -s '^O' 'ranger-cd\n'


preexec() {
	case $TERM in
		rxvt-unicode-256color | screen-256color )
			print -Pn "\e]0;$1\a" ;;
	esac
} # }}}

chpwd() {
	ls
}

# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
	local files
	IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
	[[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

# fd - cd to selected directory
fd() {
	local dir
	dir=$(find ${1:-.} -path '*/\.*' -prune \
		-o -type d -print 2> /dev/null | fzf +m) &&
		cd "$dir"
}

# fda - including hidden directories
fda() {
	local dir
	dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}

# {{{ Archiving - Compress/decompress various archive types with a single command
ark() {
	case $1 in

		e)
			case $2 in
				*.tar.bz2)   tar xvjf $2      ;;
				*.tar.gz)    tar xvzf $2      ;;
				*.bz2)       bunzip2 $2       ;;
				*.rar)       unrar x $2       ;;
				*.gz)        gunzip $2        ;;
				*.tar)       tar xvf $2       ;;
				*.tbz2)      tar xvjf $2      ;;
				*.tgz)       tar xvzf $2      ;;
				*.zip)       unzip $2         ;;
				*.Z)         uncompress $2    ;;
				*.7z)        7z x $2          ;;
				*)           echo "'$2' Unrecognized archive type" ;;
			esac ;;

		c)
			case $2 in
				*.tar.*)    arch=$2; shift 2;
					tar cvf ${arch%.*} $@
					case $arch in
						*.gz)   gzip -9r ${arch%.*}   ;;
						*.bz2)  bzip2 -9zv ${arch%.*} ;;
					esac                                ;;
				*.rar)      shift; rar a -m5 -r $@; rar k $1    ;;
				*.zip)      shift; zip -9r $@                   ;;
				*.7z)       shift; 7z a -mx9 $@                 ;;
				*)          echo "Unrecognized archive type"      ;;
			esac ;;

		*)
			echo "WHAT?" ;;

	esac
} # }}}

slideshow() {
	feh -FrzZD $1 $2
}

m () {
	echo udevil mount /dev/$1
	udevil mount /dev/$1
	echo mounted media:
	LANG=C grep --color=auto media =(mount)
}

u () {
	echo udevil umount /dev/$1
	udevil umount /dev/$1
	if [[ $1 = sr0 ]]
	then
		echo eject /dev/sr0
		eject /dev/sr0
	fi
	echo mounted media:
	LANG=C grep --color=auto media =(mount)
}
