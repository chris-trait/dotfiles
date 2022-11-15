# dotfiles

These are my configuration files for my personal `macOS` setup. They are installed as a git repository checked out directly into my home directory, inspired by [PatrickF1's dotfiles](https://github.com/PatrickF1/dotfiles).

My usual workflow uses `neovim` with `AstroNvim` config, `fish` shell, `wezterm` terminal.

## Install

```
git clone --bare git@github.com:kahnclusions/dotfiles.git ~/.dotfiles
git --git-dir=.dotfiles --work-tree=. reset --hard
git --git-dir=.dotfiles config --local status.showUntrackedFiles no
brew bundle --file=$HOME/.meta/Brewfile
```
