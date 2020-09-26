#dotfile list
~/.tmux.conf
~/.tmux-powerlinerc

$HOME___.zsh
        |  |
        |  |___.zprofile
        |  |___.zshenv
        |  |___.zsh_history
        |  |__.zshrc
        |
        |__.zshenv
        |__.zsh_history

#when add a dotfiles
setup.sh
    DOTFILES=(.addfilename)


chmod +x ~/dotfiles/setup.sh
cd ~/dotfiles
./setup.sh
