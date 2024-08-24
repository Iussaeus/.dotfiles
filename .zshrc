# The following lines were added by compinstall
zstyle :compinstall filename '/home/john/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
neofetch

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

alias yazi=yy

alias vim=nvim

export EDITOR=nvim

export PATH=/home/john/.local/bin:$PATH
export PATH=/home/john/.local/share/JetBrains/Toolbox/scripts/:$PATH

eval "$(starship init zsh)"

# opam configuration
[[ ! -r /home/john/.opam/opam-init/init.zsh ]] || source /home/john/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null
