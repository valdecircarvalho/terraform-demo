#!/usr/bin/env bash

sudo apt-get update
sudo apt-get -y install apache2 php
sleep 5s
sudo git clone https://github.com/valdecircarvalho/terraform-demo 
cd terraform-demo
sudo cp -rv /terraform-demo/demo-aws-usergroup-sp/src/app-web/* /var/www/html/
sudo rm /var/www/html/index.html
sudo rm -rf /terraform-demo
