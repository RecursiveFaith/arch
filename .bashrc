#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

alias vi='vim'
alias cb='xsel -ib'

export DIARY_HISTORY="$HOME/gnostic/history.md"
export HEY_BASE="$HOME/gnostic/projects/hey"
export HEY_GIT="$HOME/gnostic/projects/bot/git.sh"
export HEY_MODEL='google/gemini-2.0-flash-001'
export API_OPENROUTER='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'
alias save="$HOME/gnostic/projects/hey/bot/git.sh"
alias hey="$HOME/gnostic/projects/hey/chat.sh"
export chat="$HOME/gnostic/projects/hey/chat.sh"
alias sshadd="eval $(ssh-agent); ssh-add"

# Foreground colors
export BLACK='\033[30m'
export RED='\033[31m'
export GREEN='\033[32m'
export YELLOW='\033[33m'
export BLUE='\033[34m'
export MAGENTA='\033[35m'
export CYAN='\033[36m'
export WHITE='\033[37m'

# Bright foreground colors
export BRIGHT_BLACK='\033[90m'
export BRIGHT_RED='\033[91m'
export BRIGHT_GREEN='\033[92m'
export BRIGHT_YELLOW='\033[93m'
export BRIGHT_BLUE='\033[94m'
export BRIGHT_MAGENTA='\033[95m'
export BRIGHT_CYAN='\033[96m'
export BRIGHT_WHITE='\033[97m'

# Background colors
export BG_BLACK='\033[40m'
export BG_RED='\033[41m'
export BG_GREEN='\033[42m'
export BG_YELLOW='\033[43m'
export BG_BLUE='\033[44m'
export BG_MAGENTA='\033[45m'
export BG_CYAN='\033[46m'
export BG_WHITE='\033[47m'

# Bright background colors
export BG_BRIGHT_BLACK='\033[100m'
export BG_BRIGHT_RED='\033[101m'
export BG_BRIGHT_GREEN='\033[102m'
export BG_BRIGHT_YELLOW='\033[103m'
export BG_BRIGHT_BLUE='\033[104m'
export BG_BRIGHT_MAGENTA='\033[105m'
export BG_BRIGHT_CYAN='\033[106m'
export BG_BRIGHT_WHITE='\033[107m'

# Reset color
export RESET='\033[0m'
