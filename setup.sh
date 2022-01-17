#!/usr/bin/bash
sleep 30
cd /var/www && sudo chown -R ubuntu:ubuntu .
sudo cp -R P161App /var/www/
sudo apt-get update
sudo apt-get install curl -y
sudo apt install gnupg -y
sudo apt install awscli -y
sudo apt install nodejs -y
sudo apt-get install -y nginx
sudo service nginx restart


# Install our PGP key and add HTTPS support for APT
sudo apt-get install -y dirmngr gnupg
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7
sudo apt-get install -y apt-transport-https ca-certificates

# Add our APT repository
sudo sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger focal main > /etc/apt/sources.list.d/passenger.list'
sudo apt-get update

# Install Passenger + Nginx module
sudo apt-get install -y libnginx-mod-http-passenger

if [ ! -f /etc/nginx/modules-enabled/50-mod-http-passenger.conf ]; then sudo ln -s /usr/share/nginx/modules-available/mod-http-passenger.load /etc/nginx/modules-enabled/50-mod-http-passenger.conf ; fi

sudo ls /etc/nginx/conf.d/mod-http-passenger.conf
sudo service nginx restart
sudo /usr/bin/passenger-config validate-install --auto

curl -sSL https://rvm.io/mpapis.asc | sudo gpg --import -
curl -sSL https://rvm.io/pkuczynski.asc | sudo gpg --import -
curl -sSL https://get.rvm.io | sudo bash -s stable
source /etc/profile.d/rvm.sh
rvm user all
rvm requirements
rvm install ruby-2.6.6
rvm use 2.6.6 --default
sudo apt-get install libmysqlclient-dev -y
sudo apt install mysql-client -y
sudo rm /etc/nginx/sites-enabled/default
sudo mv default /etc/nginx/sites-enabled/default

cd /var/www/P161App && bundle install

#cd /var/www/P161App && sudo chown -R ubuntu:ubuntu .
#export EDITOR=vim
#sudo rm /var/www/P161App/config/credentials.yml.enc
#cd /var/www/P161App && rails credentials:edit
cd /var/www/P161App && sudo chown -R www-data:www-data .
sudo service nginx restart

curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update
sudo apt-get install -y yarn

