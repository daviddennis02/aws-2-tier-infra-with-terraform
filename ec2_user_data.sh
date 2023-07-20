#!/bin/bash -xe

sudo yum -y update
sudo yum install -y httpd wget
sudo systemctl start httpd
sudo systemctl enable httpd
echo "<html><body><h1>Welcome to AWS WebTier One 2023! Powered byTerraform </h1></body></html>" | sudo tee /var/www/html/index.html
