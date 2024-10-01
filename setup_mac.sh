#!/bin/bash

RUBY_VERSION=latest
NODE_VERSION=latest
POSTGRES_VERSION=14.4

set -e

ln -s ./home/.zshrc ~/.zshrc
ln -s ./home/.vimrc ~/.vimrc
ln -s ./home/.gitignore_global ~/.gitignore_global

sudo cp ./etc/hosts /etc/hosts
mkdir ~/.postgres

xcode-select --install

bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install zsh
chsh -s /usr/local/bin/zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

brew install python
brew install neovim
pip3 install --user neovim

brew tap homebrew/cask-versions

brew install gcc llvm http-server readline zlib ossp-uuid coreutils libpq nss imagemagick curl mkcert git gpg gawk zsh yarn asdf
brew install stripe/stripe-cli/stripe

asdf plugin add ruby
asdf install ruby $RUBY_VERSION
asdf global ruby $RUBY_VERSION

asdf plugin add nodejs
asdf install nodejs $NODE_VERSION
asdf global nodejs $NODE_VERSION

asdf plugin add postgres
asdf install postgres $POSTGRES_VERSION

brew install fzf
brew install ripgrep
brew install libyaml
brew install git
brew install git-absorb
brew install gh
brew install thefuck
brew install mas
brew install redis
brew install shared-mime-info

brew tap heroku/brew && brew install heroku

brew install --cask iterm2
brew install --cask vscodium
brew install --cask slack
brew install --cask zoom
brew install --cask whatsapp
brew install --cask google-chrome
brew install --cask google-chat
brew install --cask postman
brew install --cask spectacle
brew install --cask firefox-developer-edition

apps_to_open_at_login=(Harvest iTerm Slack Spectacle)
for app in $apps_to_open_at_login
  osascript -e  "tell application \"System Events\" to make login item at end with properties { path: \"/Applications/$app.app\", hidden: false }"

mkdir -p ~/.config/nvim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
sudo cp ./config/nvim/init.vim ~/.config/nvim/init.vim
sudo chown -R $USER ~/.vim ~/.local ~/.config /Library/Ruby
vim +PluginInstall

git config --global core.excludesfile ~/.gitignore_global
git config --global user.name "luca-landa"
git config --global user.email "lucalanda@hotmail.it"
