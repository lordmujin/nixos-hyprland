#
# ~/.bashrc
#

[[ $- != *i* ]] && return

alias ls='eza --color=auto --icons=always'
alias grep='grep --color=auto'
alias cmatrix='cmatrix -C blue'
alias asciiquarium='asciiquarium -t'

alias nixconfig='sudo micro /etc/nixos/configuration.nix'
alias hyprconfig='micro ~/.config/hypr/hyprland.conf'

PS1="\[\033[32m\][\w]\[\033[0m\]\n\[\033[1;36m\]\u\[\033[1;33m\]-> \[\033[0m\]"

pokeget random --hide-name | fastfetch --file-raw -
