# The following lines were added by compinstall
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

HISTFILE=${HISTFILE:-"$HOME/.histfile"}
HISTSIZE=1000
SAVEHIST=1000
unsetopt sharehistory
setopt HIST_IGNORE_SPACE
setopt APPEND_HISTORY
autoload -U +X bashcompinit && bashcompinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

command -v > /dev/null neofetch && neofetch ||
command -v > /dev/null fastfetch && fastfetch

command -v zoxide > /dev/null && eval "$(zoxide init zsh)"
command -v starship > /dev/null && eval "$(starship init zsh)"
command -v opam > /dev/null && eval "$(opam env)"

export EDITOR=nvim
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/go/bin:$PATH
export PATH=$HOME/.local/share/flatpack/exports/share:$PATH
export PATH=/var/lib/flatpak/exports/bin:$PATH
export XDG_DATA_DIR=/var/lib/flatpak/exports/share:$XDG_DATA_DIR
export XDG_DATA_DIR=$HOME/.local/share/flatpak/exports/share:$XDG_DATA_DIR
export TMUX_SESSIONIZER_PROJECTS_DIR="$HOME/code"
export npm_config_prefix="$HOME/.local"

alias zd=z
alias ls='ls --color=auto'
alias grep='grep --color=auto'

function Resume {  
    if [ -z "$(jobs)" ]; then
        return
    fi

    fg
    zle reset-prompt
} 
zle -N Resume
bindkey "^Z" Resume
