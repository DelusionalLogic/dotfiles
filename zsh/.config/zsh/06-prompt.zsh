local IT="${terminfo[sitm]}${terminfo[bold]}"
local ST="${terminfo[sgr0]}${terminfo[ritm]}"

local FMT_BRANCH="%F{2}(%s:%F{7}%{$IT%}%r%{$ST%}%F{2}) %F{11}%B%b %K{0}%{$IT%}%u%c%{$ST%}%k"
local FMT_ACTION="(%F{3}%a%f)"
local FMT_PATH="%F{1}%R%F{2}/%S%f"

function setprompt() {
	local MODE="${${KEYMAP/vicmd/"%F{6}normal%f"}/(main|viins)/"%F{5}insert%f"}"
	local HOST="%F{1}$HOST%f"
	local USER="%(#.%F{1}.%F{3})%n%f"
	local PWD="%F{7}$($XDG_CONFIG_HOME/zsh/rzsh_path)%f"
	local TTY="%F{4}%y%f"
	local EXIT="%(?..%F{202}%?%f)"
	local PRMPT="${USER}@${HOST}:${MODE}:${TTY}: ${PWD} 
${EXIT} %F{202}»%f "

	if [[ "${vcs_info_msg_0_}" == "" ]]; then
		PROMPT="$PRMPT"
	else
		PROMPT="${vcs_info_msg_0_}
$PRMPT"
	fi
}
