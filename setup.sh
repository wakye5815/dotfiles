/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/$(whoami)/.zprofile
. /Users/$(whoami)/.zprofile

brew install google-chrome

brew install rectangle

brew install visual-studio-code

brew install --cask docker

brew install mise
echo 'eval "$(mise activate zsh)"' >> ~/.zshrc

brew install --cask ghostty

brew install zplug