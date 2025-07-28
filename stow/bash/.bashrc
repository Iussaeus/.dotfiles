#
# ~/.bashrc
#

# If not running interactively, don't do anything
set -o vi

[[ $- != *i* ]] && return

eval "$(starship init bash)"

alias ls='ls --color=auto'

alias grep='grep --color=auto'

PS1='[\u@\h \W]\$ '

export EDITOR=nvim
alias vim=nvim

alias rebooty=reboot

#I use arch btw
neofetch

bind -s 'set completion-ignore-case on'

#shell wrapper for yazi to change current directory
function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

alias yazi=yy

export PATH=/home/john/.local/bin:$PATH

export PATH=$PATH:/home/john/.spicetify

complete -C /home/john/go/bin/gocomplete go

complete -C /usr/bin/gocomplete go
