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

[ -s $HOME/.cargo/env ] && source $HOME/.cargo/env

alias ls="exa"
alias l="exa -l"
alias ll="exa -la"

PS1="\[\033[38;5;10m\]λ\[$(tput sgr0)\] \[$(tput sgr0)\]\[\033[38;5;196m\]\$?\[$(tput sgr0)\] \[$(tput sgr0)\]\[\033[38;5;12m\]\W\[$(tput sgr0)\] \e[m"
alias h="echo h"
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias reload="source $HOME/.bashrc"
alias epitest="docker run --rm -it -v $(pwd):/usr/src/project epitechcontent/epitest-docker /bin/bash -c \"cd /usr/src/project; exec bash\""
alias sendhtmltoserver="rsync -r . okami-root:/root/services/huntears.com/data/html/"
alias perfrep="perf report -g 'graph,0.5,caller'"
alias perfrec="perf record -g"
alias build="make --directory build"

export MAKEFLAGS="-j14"

export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.cargo/bin"
export PF_INFO="ascii title os host kernel uptime pkgs memory shell"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pnpm
export PNPM_HOME="/home/huntears/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

[ -s $HOME/.ghcup/env ] && source $HOME/.ghcup/env

export GPG_TTY=$(tty)

function update() {
    sudo bash -c "emaint -a sync && emerge -avuDN @world && eix-update"
}

export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"
