#!/bin/bash


function status_message {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}


read -p "Enter the remote IP address: " ip_address
read -p "Enter the remote username: " username


if [[ -z "$ip_address" || -z "$username" ]]; then
  echo "Error: IP address and username must not be empty."
  exit 1
fi


read -p "Enter the public key you want to check: " public_key


if [[ -z "$public_key" ]]; then
  echo "Error: Public key must not be empty."
  exit 1
fi


key_with_username="$username@$ip_address $public_key"


status_message "Checking if the public key exists on the remote machine..."
remote_authorized_keys=$(ssh -o BatchMode=yes -o StrictHostKeyChecking=no "$username"@"$ip_address" "cat ~/.ssh/authorized_keys")

if grep -q "$public_key" <<< "$remote_authorized_keys"; then
  status_message "The public key already exists in the authorized keys for the specified user."
else

  status_message "Adding the public key to the authorized keys..."
  ssh -o StrictHostKeyChecking=no "$username"@"$ip_address" "echo '$public_key' >> ~/.ssh/authorized_keys"
  status_message "The public key has been added to the authorized keys for the specified user."
fi


status_message "Disconnecting from the remote machine..."
ssh -o BatchMode=yes "$username"@"$ip_address" "exit"

status_message "Script execution completed."
