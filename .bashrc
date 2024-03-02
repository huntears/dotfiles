#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ -z "$FUNCNEST" ]] && export FUNCNEST=100          # limits recursive functions, see 'man bash'

# Sets the prompt
# Literally the default from gentoo
# Taken from: https://gitweb.gentoo.org/repo/gentoo.git/tree/app-shells/bash/files/bashrc
# Just changed it so that it shows the full hostname (Distrobox for example)
PS1="\[\033[01;32m\]\u@\H\[\033[01;34m\] \w \$\[\033[00m\] "

## Use the up and down arrow keys for finding a command in history
## (you can write some initial letters of the command first).
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

# Add cargo installed binaries available to the shell (exa, onefetch, tokei...)
[ -s $HOME/.cargo/env ] && source $HOME/.cargo/env

# tbh I only use eza because the colours look good, if there is an alternative I will switch
alias ls="eza --git --git-ignore"
alias l="eza -lh --git --git-ignore"
alias ll="eza -lah --git -M"

alias h="echo h"
# Quick source alias when I change something in my config
alias reload="source $HOME/.bashrc"
# Legacy because distrobox is a thing, keeping it for history's sake
alias epitest="docker run --rm -it -v $(pwd):/usr/src/project epitechcontent/epitest-docker /bin/bash -c \"cd /usr/src/project; exec bash\""
# I hate perf so much for this >:(
alias perfrep="perf report -g 'graph,0.5,caller'"
alias perfrec="perf record -g"
# Quick alias for when I am lazy in vim
alias build="make --directory build"
# Removes all local git branches that are not on the remote, you may want to call `git remote prune origin` before
alias git-remove-untracked='git fetch --prune && git branch -r | awk "{print \$1}" | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk "{print \$1}" | xargs git branch -d'
alias time="$(which time) -f '\t%E real,\t%U user,\t%S sys,\t%K amem,\t%M mmem'"

function update_rustpkgs() {
    cat ~/.cargo/.crates2.json | jq -r '.installs | keys[] | split(" ")[0]' | xargs cargo install
}

# Make go brrrrrrrr (You definetely want to change this if your pc doesn't have 16 cores and 32GB of RAM)
export MAKEFLAGS="-j14"

# Pip binaries
export PATH="$PATH:$HOME/.local/bin"
# Rust/Cargo binaries (Shouldn't be needed but you never know)
export PATH="$PATH:$HOME/.cargo/bin"
# pfetch config (Yes that is how you configure it, yes I hate it)
export PF_INFO="ascii title os host kernel uptime pkgs memory shell"

# I don't even remember what nvm is anymore but it sounds like js and I am too scared to touch it for now xd
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

# Haskell version managere
export PATH="$PATH:$HOME/.ghcup/bin"

# gpg signing in terminal without a secrets manager
export GPG_TTY=$(tty)

# Gentoo goes brrrrrrrrrr
# It first pulls from the repoes, emerges needed packages, then updates eix's package cache
function update() {
    sudo bash -c "emaint -a sync && emerge -avuDN @world && eix-update"
}

# Export some XDG specific variable so xdg-ninja is no longer complaining
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH

export PATH=$PATH:$HOME/go/bin

export EDITOR=vim
export VISUAL=vim

# Temporary, this will be moved elsewhere
. $HOME/programs/cloned/bash-wakatime/bash-wakatime.sh

alias wttr="curl https://wttr.in/toulouse"

# THIS NEEDS TO BE LAUNCHED FROM THE HOME DIRECTORY WHILE THE BACKUP DRIVE IS MOUNTED ON ~/backups
# IT IS VERY BADLY DONE!
alias backup_everything="restic --repo backups/ backup . --exclude .cache --exclude .mozilla --exclude .ghcup --exclude backups --exclude .local --exclude .rustup --exclude .var --exclude .debug --exclude .cargo --exclude .pnpm-store"
alias format-all="find cubic-server/ -iname *.hpp -o iname *.cpp | xargs clang-format --style=file -i"
