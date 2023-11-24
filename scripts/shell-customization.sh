#!/bin/sh

# Function to setup XDG user dirs
setupXDGUserDirs() {

  for dirname in "$@"; do
    newdirname="$(echo "$dirname" | awk '{print tolower($0)}')"

    if [ -d "$dirname" ]; then
      mv "$dirname" "$newdirname"
    else
      mkdir "$newdirname"
    fi
  done

  cp ../dotfiles/user-dirs.dirs ~/.config/
  xdg-user-dirs-update

}

# Shell choice
shellChoice() {

  echo "Which shell you prefer?"
  echo "[1] Bash"
  echo "[2] Fish"
  echo "[3] Zsh"
  echo "If unsure, select Bash."
  echo "Choose an option (1/2/3) : " && read -r shell_choice
  [ "$shell_choice" -lt 1 ] || [ "$shell_choice" -gt 3 ] && printf "\n[ $shell_choice is an invalid Choice..\!\! ]\n\n" && shellChoice

}

# Change directory
SCRIPT_DIR=$(dirname -- "$( readlink -f -- "$0"; )") && cd "$SCRIPT_DIR" || exit

# Installation
shellChoice
sudo apt-get update && sudo apt-get -y install curl autojump bat neofetch trash-cli wget tldr fzf command-not-found git micro btop fonts-font-awesome fonts-noto-color-emoji

# Install utilities for extract function
sudo apt-get install -y tar xz-utils bzip2 unrar-free gzip unzip p7zip-full cabextract cpio unace

# Install lsd
if apt-cache show lsd > /dev/null; then
  sudo apt-get install -y lsd
else
  wget https://github.com/lsd-rs/lsd/releases/download/0.23.1/lsd_0.23.1_amd64.deb
  sudo dpkg -i lsd_0.23.1_amd64.deb
  rm lsd_0.23.1_amd64.deb
fi

# Shell choice
sudo apt-get -y install bash-completion # install bash customisations
sudo apt-get -y install fish python-is-python3 # install fish customisations
sudo apt-get -y install zsh zsh-autosuggestions zsh-syntax-highlighting # install zsh customisations
# Set dotfile directory for zsh
sudo sed -i '$ a\\n###\ SET\ XDG\ DIR\ FOR\ ZSH\ ###\nZDOTDIR=~/.config/zsh\n' /etc/zsh/zshenv
 
case $shell_choice in
    1)
        while ! chsh -s "$(which bash)"; do :; done;;
    2)
        while ! chsh -s "$(which fish)"; do :; done;;
    3)
        while ! chsh -s "$(which zsh)"; do :; done;;
esac

# Setup Starship
curl -sS https://starship.rs/install.sh | sh

# Setup Directories
setupXDGUserDirs ~/Desktop ~/Documents ~/Downloads ~/Music ~/Pictures ~/Templates ~/Videos ~/Public
rm -d ~/desktop ~/music ~/templates ~/public
mkdir -p ~/downloads/kdeconnect

# Shell color scripts
(cd ~ && git clone https://github.com/shreyas-a-s/shell-color-scripts.git && cd shell-color-scripts/ && sudo make install)

# Add password feedback (asterisks) for sudo
echo 'Defaults    pwfeedback' | sudo tee -a /etc/sudoers > /dev/null

# Copy config file for micro
mkdir -p ~/.config/micro/

# Update database of command-not-found
sudo update-command-not-found
sudo apt update

# Install neovim
if [ "$(apt-cache show neovim | grep Version | awk -F '.' '{print $2}')" -ge 9 ]; then
  sudo apt-get install -y neovim
else
  ./neovim-appimage-updater.sh
  sudo cp neovim-appimage-updater.sh /usr/local/bin/neovim-appimage-updater
fi

# Set default text editor
if which nvim > /dev/null; then
  sudo update-alternatives --set editor $(which nvim)
elif which micro > /dev/null; then
  sudo update-alternatives --set editor $(which micro)
else
  sudo update-alternatives --set editor $(which nano)
fi

# Update tldr database
tldr -u

