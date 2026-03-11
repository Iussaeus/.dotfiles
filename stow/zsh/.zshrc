# The following lines were added by compinstall
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

HISTFILE=${HISTFILE:-"$HOME/.histfile"}
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
unsetopt sharehistory
setopt HIST_IGNORE_SPACE
setopt APPEND_HISTORY
autoload -U +X bashcompinit && bashcompinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

command -v > /dev/null neofetch && neofetch
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

alias zd=z
alias ls='ls --color=auto'
alias grep='grep --color=auto'

function Resume {  
    [ -z "$(jobs)" ] && return
    fg
    # restore position of the cursor
    printf '\e[G\e[5A\e[0J'
    zle reset-prompt
} 
zle -N Resume
bindkey "^Z" Resume

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

    expr=$(($expr))

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
    oct)  printf "0%o\n" $expr ;;
    hex)  printf "0x%X\n" $expr ;;
    *)    printf "%.3f\n" $expr ;;
esac
}

# tmux-sessionizer completion with children of TMUX_SESSIONIZER_PROJECTS_DIR
_tmux_sessionizer_dirs() {
    local -a children
    local d entry name
    d=${TMUX_SESSIONIZER_PROJECTS_DIR:-"$HOME/code"}
    [[ -n $d && -d $d ]] || return 1
    for entry in "$d"/*(/); do
        [[ -n $entry ]] || continue
        name=${entry:t}    # basename
        children+=("${name%/}")
    done
    _describe -t tmux-sessionizer-dirs 'project directories' children
}
compdef '_arguments "*:project-dir:_tmux_sessionizer_dirs"' tmux-sessionizer
