set -o vi
bind -s 'set completion-ignore-case on'

command -v starship > /dev/null && eval "$(starship init bash)"

alias ls='ls --color=auto'
alias grep='grep --color=auto'

export EDITOR=nvim
export TMUX_SESSIONIZER_PROJECTS_DIR="$HOME/code"
export PATH=/home/john/.local/bin:$PATH
