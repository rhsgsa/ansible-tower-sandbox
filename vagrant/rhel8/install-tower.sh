#!/bin/bash

sudo yum install ansible curl vim -y && \
export installer_folder=/tmp/installer && \
mkdir -p $installer_folder && cd $installer_folder && \
curl -kL -O --output $installer_folder/ansible-tower-setup-latest.tar.gz https://releases.ansible.com/ansible-tower/setup/ansible-tower-setup-latest.tar.gz && \
tar xvzf $installer_folder/ansible-tower-setup-latest.tar.gz && \
cd $(ls -d $installer_folder/*/|head -n 1)  && \
export setup_folder=$(pwd)  && \
sed -i -e "s/admin_password=''/admin_password='password'/" $setup_folder/inventory && \
sed -i -e "s/pg_password=''/pg_password='password'/" $setup_folder/inventory && \
secret_hash=$(openssl rand -base64 30) && \
echo "secret_key=$secret_hash" >> $setup_folder/inventory && \
$setup_folder/setup.sh


firewall-cmd --zone=public --add-masquerade --permanent
firewall-cmd --permanent --add-service=http
firewall-cmd --permanent --add-service=https
firewall-cmd --reload