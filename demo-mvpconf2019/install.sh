#!/usr/bin/env bash
set -e

echo "==> Installing packages..."
sudo apt-get -qq update
sudo apt-get -yqq install nginx git

echo "==> Setup website demo..."
cd /home/azureuser/
sudo git clone https://github.com/valdecircarvalho/terraform
cd terraform
sudo cp -r . /var/www/html/
