#!/usr/bin/env bash

# update and install unzip
sudo apt-get update
sudo apt-get install unzip -y

# download and install vault
cd /tmp
wget https://releases.hashicorp.com/vault/1.3.1/vault_1.3.1_linux_amd64.zip
unzip vault_*.zip
sudo cp vault /usr/local/bin 

# enable autocompletion for vault flags, subcommands, and arguments
vault -autocomplete-install
complete -C /usr/local/bin/vault vault

# prevent memory from being swapped to disk without running the process as root
sudo setcap cap_ipc_lock=+ep /usr/local/bin/vault

# create the vault.d directory in /etc
sudo mkdir --parents /etc/vault.d

# move the config files to their appropriate locations
sudo mv /home/vault/vault.hcl /etc/vault.d/vault.hcl
sudo mv /home/vault/vault.service /etc/systemd/system/vault.service

# create a system user 
sudo useradd --system --home /etc/vault.d --shell /bin/false vault

# give ownership of everything in the vault.d directory to the vault user
sudo chown --recursive vault:vault /etc/vault.d

# give read/write access to the vault.hcl file
sudo chown 640 /etc/vault.d/vault.hcl

# enable and start the vault server
sudo systemctl enable vault
sudo systemctl start vault


