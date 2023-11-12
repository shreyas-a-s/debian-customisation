#!/bin/sh
sudo apt-get update && sudo apt-get -y install curl
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
# To set third-party repositories to have least priority
echo 'Package: *
Pin: origin brave-browser-apt-release.s3.brave.com
Pin-Priority: 100' | sudo tee /etc/apt/preferences.d/brave.pref > /dev/null
sudo apt-get update && sudo apt-get -y install brave-browser
