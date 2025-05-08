if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting

alias ls="eza -a --icons"
alias ll="eza -al --icons"
alias grep="grep --color=auto"
alias cmatrix="cmatrix -C blue"
alias asciiquarium="asciiquarium -t"

alias nixconfig="sudo micro /etc/nixos/configuration.nix"

pokeget random --hide-name | fastfetch --file-raw -
