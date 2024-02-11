local IT="${terminfo[sitm]}${terminfo[bold]}"
local ST="${terminfo[sgr0]}${terminfo[ritm]}"

export FMT_BRANCH="%F{2}(%s:%F{7}%{$IT%}%r%{$ST%}%F{2}) %F{11}%B%b %K{0}%{$IT%}%u%c%{$ST%}%k"
export FMT_ACTION="(%F{3}%a%f)"
export FMT_PATH="%F{1}%R%F{2}/%S%f"

function make_path() {
	local dir="${PWD/#${HOME}/~/}"
	local parts=(${(s|/|)dir})
	local color=1
	for part in "${parts[@]}"; do
		if [[ "$color" -gt 1 ]];  then
			printf "%%F{$color} \u00BB "
		fi
		printf "%%F{8}$part"
		((color+=1))
	done
}

function setprompt() {
	local MODE="${${KEYMAP/vicmd/"%F{2}n%f"}/(main|viins)/"%F{4}i%f"}"
	local HOST="%F{1}$HOST%f"
	local USER="%(#.%F{1}.%F{3})%n%f"
	local PWD="%F{7}$(make_path)%f"
	local EXIT="%(?..%F{202}%?%f)"
	local PRMPT="${USER}@${HOST}:${MODE}: ${PWD} 
${EXIT} %F{202}»%f "

	if [[ "${vcs_info_msg_0_}" == "" ]]; then
		PROMPT="$PRMPT"
	else
		PROMPT="${vcs_info_msg_0_}
$PRMPT"
	fi
}
