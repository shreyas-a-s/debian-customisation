#!/bin/bash

# Variables
debianversion=$(cat /etc/debian_version)

if [ "$debianversion" -ge 12 ]; then
    sudo apt-get -y install nala
fi