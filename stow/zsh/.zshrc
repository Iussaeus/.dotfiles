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

export EDITOR=nvim
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/go/bin:$PATH
export PATH=$HOME/.local/share/flatpack/exports/share:$PATH
export PATH=/var/lib/flatpak/exports/bin:$PATH
export XDG_DATA_DIR=/var/lib/flatpak/exports/share:$XDG_DATA_DIR
export XDG_DATA_DIR=$HOME/.local/share/flatpak/exports/share:$XDG_DATA_DIR

alias zd=z

calc() {
    [[ $# -eq 0 ]] && return

    local mode="dec"
    local expr=""
    if [ $# -gt 1 ]; then
        while [[ $# -gt 0 ]]; do
            case "$1" in
                -b)     mode="bin"     ;;
                -o)     mode="oct"     ;;
                -x| -h) mode="hex"     ;;
                *)      expr="$expr$1" ;;
            esac;
            shift
        done
    else
        expr=$*
    fi

  case "$mode" in
    bin) awk "
      function tobin(n){
        if(n==0) return \"0\"
        s=\"\"; if(n<0){ n=-n; neg=1 } else neg=0
        while(n>0){ s = (n%2) s; n = int(n/2) }
        if(neg) s = \"-\" s
        return s
      }
      BEGIN{ printf \"%s\n\", tobin($expr) }"
      ;;
    oct) awk "BEGIN{ printf \"0%o\n\", ($expr) }"  ;;
    hex) awk "BEGIN{ printf \"0x%X\n\", ($expr) }" ;;
    *)   awk "BEGIN{ printf \"%.3f\n\", ($expr) }" ;;
  esac
}

