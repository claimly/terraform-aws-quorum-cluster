#!/bin/bash
set -u -o pipefail

# Set vault address since this will be run by user-data
export VAULT_ADDR=https://vault.service.consul:8200

function wait_for_successful_command {
    local COMMAND=$1

    $COMMAND
    until [ $? -eq 0 ]
    do
        sleep 5
        $COMMAND
    done
}

# Wait for operator to initialize and unseal vault
wait_for_successful_command 'vault init -check'
wait_for_successful_command 'vault status'

# Wait for vault to be fully configured by the root user
wait_for_successful_command 'vault auth -method=aws'

# Get the overall index, IP, and boot port for this instance
INDEX=$(cat /opt/quorum/info/index.txt)
PRIVATE_IP=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)
BOOT_PORT=30301

# Generate bootnode key and construct bootnode address
BOOT_KEY=/opt/quorum/private/boot.key
BOOT_ADDR_FILE=/opt/quorum/private/boot_addr
if [ -e $BOOT_ADDR_FILE ]
then
    BOOT_ADDR=$(cat $BOOT_ADDR_FILE)
else
    BOOT_PUB=$(bootnode --genkey=$BOOT_KEY --writeaddress)
    BOOT_ADDR="enode://$BOOT_PUB@$PRIVATE_IP:$BOOT_PORT"
    echo $BOOT_ADDR > $BOOT_ADDR_FILE
fi

# Write bootnode address to vault
vault write quorum/bootnodes/$INDEX enode="$BOOT_ADDR"

# Run the bootnode
sudo mv /opt/quorum/private/bootnode-supervisor.conf /etc/supervisor/conf.d/
sudo supervisorctl reread
sudo supervisorctl update
