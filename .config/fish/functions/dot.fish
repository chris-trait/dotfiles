function dot --wraps=git --description 'Manage dotfiles repository with home as working directory'
    git --git-dir="$DOTFILES/.git" --work-tree="$HOME" $argv
end
