#!/usr/bin/env bash

echo "==> Installing packages..."
sudo apt-get -qq update
sudo apt-get -yqq install apache2 php git

echo "==> Setup website demo..."
cd $HOME ## arrumar se o nome do usuario azure for diferente 
sudo git clone https://github.com/valdecircarvalho/terraform-demo ## arrumar o caminho, caso você clone o repo
cd terraform-demo
sudo rm -rf demo*
sudo rm README.md
sudo rm /var/www/html/index.html
sudo cp -r . /var/www/html/


