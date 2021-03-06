#!/bin/bash
# Bootstrap script for setting up a new OSX machine
# 
# This should be idempotent so it can be run multiple times.
#
# Some apps don't have a cask and so still need to be installed by hand. These
# include:
#
# - Twitter (app store)
# - Postgres.app (http://postgresapp.com/)
#
# Notes:
#
# - If installing full Xcode, it's better to install that first from the app
#   store before running the bootstrap script. Otherwise, Homebrew can't access
#   the Xcode libraries as the agreement hasn't been accepted yet.
#
# Reading:
#
# - http://lapwinglabs.com/blog/hacker-guide-to-setting-up-your-mac
# - https://gist.github.com/MatthewMueller/e22d9840f9ea2fee4716
# - https://news.ycombinator.com/item?id=8402079
# - http://notes.jerzygangi.com/the-best-pgp-tutorial-for-mac-os-x-ever/

echo "Starting bootstrapping"
unameOut="$(uname -s)"
case "${unameOut}" in
	Linux*)     machine=Linux;;
	Darwin*)    machine=Mac;;
	CYGWIN*)    machine=Cygwin;;
	MINGW*)     machine=MinGw;;
	*)          machine="UNKNOWN:${unameOut}"
esac

# Check for Homebrew, install if we don't have it
if test ! $(which brew); then
	echo "Installing homebrew..."
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes
brew update

if [ "$machine" == "Mac" ]; then
	echo "Installing GNU versions of Mac Utils"
	# Install GNU core utilities (those that come with OS X are outdated)
	brew install coreutils
	brew install gnu-sed 
	brew install gnu-tar 
	brew install gnu-indent 
	brew install gnu-which 

	# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
	brew install findutils

	# Install Bash 4
	brew install bash
fi

#Install mcfly for better ctrl-r experience
brew tap cantino/mcfly https://github.com/cantino/mcfly

PACKAGES=(
ack
autoconf
automake
awscli
bat
borkdude/brew/clj-kondo
broot
clojure
ctags
git-delta
exa
fasd
ffmpeg
fzf
git
htop
imagemagick
ispell
jq
leiningen
mcfly
mosh
ncdu
neovim
nodejs
npm
planck
pt
python
python3
ripgrep
ssh-copy-id
telnet
terminal-notifier
the_silver_searcher
tldr
tmux
tree
watch
wget
yarn
youtube-dl
zsh
zsh-syntax-highlighting
zsh-autosuggestions
)

echo "Installing packages..."
brew install ${PACKAGES[@]}

echo "Cleaning up..."
brew cleanup


if [ "$machine" == "Mac" ]; then
	CASKS=(
	dropbox
	firefox
	flux
	google-chrome
	iina
	insomnia
	iterm2
	jetbrains-toolbox
	pocket-casts
	slack
	spectacle
	twitch
	whatsapp
	vlc
	)

	echo "Installing cask apps..."
	brew cask install ${CASKS[@]}
fi

echo "Installing fonts..."
FONTS=(
font-dejavu-sans
font-dejavu-sans-mono-for-powerline
font-hack
font-fira-code
font-roboto
font-source-code-pro
)
brew cask install ${FONTS[@]}

echo "Installing Python packages..."
PYTHON_PACKAGES=(
virtualenv
virtualenvwrapper
)
sudo pip install ${PYTHON_PACKAGES[@]}

echo "Configuring OSX..."

# Set fast key repeat rate
defaults write NSGlobalDomain KeyRepeat -int 0
# Require password as soon as screensaver or sleep mode starts
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

echo "Setting up Oh-My-Zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
