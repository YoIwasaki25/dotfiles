#!/bin/sh

DOT_FILES=(.tmux.conf .tmux-powerlinerc)
for file in ${DOT_FILES[@]}
do
    ln -s $HOME/dotfiles/$file $HOME/$file
done

DOT_ZSH_FILES=( .zshrc .zprofile .zsh_history .zshenv )
for file in ${DOT_ZSH_FILES[@]}
do
    ln -s $HOME/dotfiles/$file $HOME/.zsh/$file
done

