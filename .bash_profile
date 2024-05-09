#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# opam configuration
test -r /home/john/.opam/opam-init/init.sh && . /home/john/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true


# Added by Toolbox App
export PATH="$PATH:/home/john/.local/share/JetBrains/Toolbox/scripts"


export PATH=$PATH:/home/john/.spicetify
