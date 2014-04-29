VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.host_name = "foo"

  config.vm.box = "ubuntu/trusty64"

  config.vm.network :forwarded_port, guest: 80, host: 5424
  config.vm.network :forwarded_port, guest: 81, host: 5425

  config.vm.synced_folder "./app", "/app"

  config.vm.network "private_network", ip: "192.168.50.32"

  config.vm.provision :shell, :inline => <<EOF
#!/bin/bash

set -x
set -u
set -e

apt-get update


################################## PHP ########################################

apt-get install -y php5


################################## HHVM #######################################

# https://github.com/facebook/hhvm/wiki/Prebuilt-packages-on-Ubuntu-14.04
wget -O - http://dl.hhvm.com/conf/hhvm.gpg.key | apt-key add -
echo 'deb http://dl.hhvm.com/ubuntu trusty main' | tee /etc/apt/sources.list.d/hhvm.list
apt-get update
apt-get install -y hhvm


################################# Apache ######################################

apt-get install -y apache2
a2enmod proxy
a2enmod proxy_fcgi
a2enmod rewrite

rm -f /etc/apache2/sites-enabled/000-default.conf

cp /vagrant/php.conf /etc/apache2/sites-enabled/
cp /vagrant/hhvm.conf /etc/apache2/sites-enabled/


################################ Services #####################################

update-rc.d hhvm defaults
service hhvm restart

update-rc.d apache2 defaults
service apache2 restart
EOF

  config.vm.provider :virtualbox do |vb|
    vb.name = "HHVM bug"
  end
end
