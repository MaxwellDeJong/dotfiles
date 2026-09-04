#!/bin/bash
DOTFILES="$HOME/dotfiles"

ln -sf $DOTFILES/.bashrc ~/.bashrc
ln -sf $DOTFILES/.vimrc ~/.vimrc
ln -sf $DOTFILES/.tmux.conf ~/.tmux.conf
mkdir -p ~/.vim/colors
ln -sf $DOTFILES/.vim/colors/wombat256-base.vim    ~/.vim/colors/wombat256-base.vim
ln -sf $DOTFILES/.vim/colors/wombat256-local.vim   ~/.vim/colors/wombat256-local.vim
ln -sf $DOTFILES/.vim/colors/wombat256-server.vim  ~/.vim/colors/wombat256-server.vim

mkdir -p ~/.config/herdr
ln -sf $DOTFILES/herdr/config.toml ~/.config/herdr/config.toml

echo "Dotfiles installed."
echo ""
echo "Remember to manually apply VSCode settings:"
echo "  Local:  copy dotfiles/vscode/settings-local.json to the appropriate VSCode settings path"
echo "  Server: copy dotfiles/vscode/settings-server.json to ~/.vscode-server/data/Machine/settings.json"
