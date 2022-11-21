set -x DOTFILES $HOME/.dotfiles
# set -x JAVA_HOME (sdk home java 17.0.3-tem)
set -x BROWSER w3m
set -x EDITOR nvim
set -x GPG_TTY (tty)
set -x ANDROID_HOME $HOME/Library/Android/sdk
set -x PINENTRY_USER_DATA USE_CURSES=0

fish_add_path -m /opt/homebrew/bin
fish_add_path -m $HOME/Library/Application\ Support/Coursier/bin
fish_add_path -m $HOME/.cargo/bin
fish_add_path -m ~/.local/bin
fish_add_path -m $ANDROID_HOME/tools
fish_add_path -m $ANDROID_HOME/platform-tools

if status is-interactive
    starship init fish | source

    alias ls="exa --icons --header --git --group-directories-first"
    alias l="exa --icons --oneline --git --group-directories-first"
    alias ll="exa --icons --long --header --git --group-directories-first --octal-permissions --no-permissions --time-style=long-iso"
    alias lt="exa --tree --git --icons"
    alias la="exa --all --icons --long --header --git --group-directories-first --octal-permissions --no-permissions --time-style=long-iso"
end

alias dots="cd $DOTFILES"
alias gp="git pull"
alias gP="git push"
alias gs="git status"
alias gb="git checkout -b"
alias gc="git checkout"
alias gS="git stash"
alias grm="git rebase origin/master"
alias gri="git rebase -i"

alias vault-uk="VAULT_ADDR=\"https://hashicorp-vault.test.euw2.ckint.io:6661\" vault login  -method=oidc -path=okta_oidc | grep 'token  ' | awk '{print \$2}' | tee .hvault.local.token"

# pnpm
set -gx PNPM_HOME "/Users/ck/Library/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end

function set_theme_dark
  set -Ux FZF_DEFAULT_OPTS "\
  --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
  --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
  --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
end

function set_theme_light
  set -Ux FZF_DEFAULT_OPTS "\
  --color=bg+:#ccd0da,bg:#eff1f5,spinner:#dc8a78,hl:#d20f39 \
  --color=fg:#4c4f69,header:#d20f39,info:#8839ef,pointer:#dc8a78 \
  --color=marker:#dc8a78,fg+:#4c4f69,prompt:#8839ef,hl+:#d20f39"
end

function update_theme --on-variable macOS_Theme
    if [ "$macOS_Theme" = "dark" ]
        set_theme_dark
        source "$HOME/.config/fish/themes/Catppuccin Mocha.fish"
    else if [ "$macOS_Theme" = "light" ]
        set_theme_light
        source "$HOME/.config/fish/themes/Catppuccin Latte.fish"
    end
end

set system_theme (defaults read -g AppleInterfaceStyle 2> /dev/null)

if [ "$system_theme" = "Dark" ];
  set -U macOS_Theme "dark"
else;
  set -U macOS_Theme "light"
end
