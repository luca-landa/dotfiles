#!/bin/bash

cp -r ./home/* ~/

xcode-select --install

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install zsh
chsh -s /usr/local/bin/zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

brew install python
brew install neovim
pip3 install --user neovim

mkdir -p ~/.vim/bundle
mkdir -p ~/.config
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' # install vim-plug
mv ./config/nvim/init.vim ~/.config/nvim/init.vim
vim +PluginInstall

git config --global core.excludesfile ~/.gitignore_global

brew install fzf
brew install ripgrep
brew install libyaml
brew install git
brew install gh
brew install node
brew install postgres

brew install --cask iterm2
brew install --cask vscodium
brew install --cask slack
brew install --cask zoom
brew install --cask whatsapp
brew install --cask google-chrome
brew install --cask harvest
brew install --cask google-chat
brew install --cask postman
brew install --cask spectacle
