# {{{ Title stuffs
precmd() {

	vcs_info
	setprompt

	case $TERM in
		rxvt-unicode-256color | screen-256color ) 
			print -Pn "\e]0;%n@%m: %~\a" ;;
	esac
}

preexec() {
	case $TERM in
		rxvt-unicode-256color | screen-256color )
			print -Pn "\e]0;$1\a" ;;
	esac
} # }}}

chpwd() {
	ls
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

# {{{ Setup empty github repo
mkgit() {
	mkdir $1
	cd $1
	git init
	touch README.markdown
	git add README.markdown
	git commit -m 'inital setup - automated'
	git remote add origin git@github.com:crshd/$1.git
	git push origin master
} # }}}
