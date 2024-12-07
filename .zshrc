ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

alias ls=eza
alias ns="nix-shell --run zsh"
alias fkb="source ~/.qmk/bin/activate && qmk compile -c && qmk flash"
eval "$(zoxide init --cmd cd zsh)"

export EDITOR=nvim
export VISUAL=nvim

[ -d "$HOME/.local/bin" ] && export PATH=$HOME/.local/bin:$PATH

[ -d "$HOME/go/bin" ] && export PATH=$HOME/go/bin:$PATH

[ -d "$HOME/.cargo/bin" ] && export PATH=$HOME/.cargo/bin:$PATH

[ -d "/home/coralynn/.cabal/bin" ] && export PATH=$HOME/.cabal/bin:$PATH

[ -f "/home/coralynn/.ghcup/env" ] && . "/home/coralynn/.ghcup/env"

[ -f "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh" ] && . "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh"

if [[ "$(tty)" == "/dev/tty1" ]] && command -v sway > /dev/null 2>&1
then
    export XDG_CURRENT_DESKTOP=sway
    export XDG_SESSION_DESKTOP="${XDG_SESSION_DESKTOP:-sway}"
    export XDG_SESSION_TYPE=wayland
    sway
fi

[ -n "$IN_NIX_SHELL" ] && export PROMPT=$PROMPT'%{$fg[blue]%}(nix-shell)%{$reset_color%} ' && echo -ne '\e[5 q'

true
