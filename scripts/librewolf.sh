#!/bin/sh
sudo apt-get update && sudo apt-get -y install wget gnupg lsb-release apt-transport-https ca-certificates
distro=$(if echo " una bookworm vanessa focal jammy bullseye vera uma " | grep -q " $(lsb_release -sc) "; then echo $(lsb_release -sc); else echo focal; fi)
wget -O- https://deb.librewolf.net/keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/librewolf.gpg
sudo tee /etc/apt/sources.list.d/librewolf.sources << EOF > /dev/null
Types: deb
URIs: https://deb.librewolf.net
Suites: $distro
Components: main
Architectures: amd64
Signed-By: /usr/share/keyrings/librewolf.gpg
EOF
# To set third-party repositories to have least priority
echo 'Package: *
Pin: origin deb.librewolf.net
Pin-Priority: 100' | sudo tee /etc/apt/preferences.d/librewolf.pref > /dev/null
sudo apt-get update && sudo apt-get -y install librewolf
