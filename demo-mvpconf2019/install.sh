## Arquivo que vai fazer o setup do website na VM

#!/usr/bin/env bash
set -e

echo "==> Installing packages..."
sudo apt-get -qq update
sudo apt-get -yqq install nginx git

echo "==> Setup website demo..."
cd /home/azureuser/ ## arrumar se o nome do usuario azure for diferente 
sudo git clone hhttps://github.com/valdecircarvalho/terraform-demo ## arrumar o caminho, caso você clone o repo
cd terraform-demo
sudo cp -r . /var/www/html/
