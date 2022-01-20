#!/bin/bash

cp -r ./home/* ~/

brew install zsh
chsh -s /usr/local/bin/zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

brew install python
brew install neovim
pip3 install --user neovim
mkdir -p ~/.vim/bundle
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
vim +PluginInstall

git config --global core.excludesfile ~/.gitignore_global

brew install iterm2

brew install fzf
brew install ripgrep
brew install libyaml
brew install git
brew install gh
brew install node
brew install postgres

brew install --cask vscodium
