## Arquivo que vai fazer o setup do website na VM

#!/usr/bin/env bash
set -e

echo "==> Installing packages..."
sudo apt-get -qq update
sudo apt-get -yqq install httpd php git

echo "==> Setup website demo..."
cd $HOME  
sudo git clone https://github.com/valdecircarvalho/terraform-demo ## arrumar o caminho, caso você clone o repo
cd terraform-demo
sudo rm -rf demo*
sudo rm README.md
sudo cp -r . /var/www/html/
