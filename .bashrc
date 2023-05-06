#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ -z "$FUNCNEST" ]] && export FUNCNEST=100          # limits recursive functions, see 'man bash'

## Use the up and down arrow keys for finding a command in history
## (you can write some initial letters of the command first).
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

. "$HOME/.cargo/env"

alias ls="exa"
alias l="exa -l"
alias ll="exa -la"

PS1="\[\033[38;5;10m\]λ\[$(tput sgr0)\] \[$(tput sgr0)\]\[\033[38;5;196m\]\$?\[$(tput sgr0)\] \[$(tput sgr0)\]\[\033[38;5;12m\]\W\[$(tput sgr0)\] "
alias h="echo h"
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias reload="source $HOME/.bashrc"
alias epitest="docker run --rm -it -v $(pwd):/usr/src/project epitechcontent/epitest-docker /bin/bash -c \"cd /usr/src/project; exec bash\""
alias sendhtmltoserver="rsync -r . okami-root:/root/services/huntears.com/data/html/"

export MAKEFLAGS="-j14"

export PATH="$PATH:$HOME/.local/bin"
export PF_INFO="ascii title os host kernel uptime pkgs memory shell"
