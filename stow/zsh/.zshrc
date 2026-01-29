# The following lines were added by compinstall
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install

neofetch 2>/dev/null || fastfetch 2>/dev/null

autoload -U +X bashcompinit && bashcompinit
unsetopt sharehistory
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

alias vim=nvim

export EDITOR=nvim
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/go/bin:$PATH
export PATH=$HOME/.local/share/flatpack/exports/share:$PATH
export PATH=/var/lib/flatpak/exports/bin:$PATH
export XDG_DATA_DIR=/var/lib/flatpak/exports/share:$XDG_DATA_DIR
export XDG_DATA_DIR=$HOME/.local/share/flatpak/exports/share:$XDG_DATA_DIR
