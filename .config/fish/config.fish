set -x DOTFILES $HOME/.dotfiles
set -x NVIM $HOME/.config/nvim

if status is-interactive
    starship init fish | source

    alias ls="exa --icons --header --git --group-directories-first"
    alias l="exa --icons --oneline --git --group-directories-first"
    alias ll="exa --icons --long --header --git --group-directories-first --octal-permissions --no-permissions --time-style=long-iso"
    alias lt="exa --tree --git --icons"
    alias la="exa --all --icons --long --header --git --group-directories-first --octal-permissions --no-permissions --time-style=long-iso"
end

# pnpm
set -gx PNPM_HOME "/Users/ck/Library/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end