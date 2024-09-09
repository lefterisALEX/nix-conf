#!/bin/bash

USERNAME="lefteris"           

sudo adduser --disabled-password --gecos "" $USERNAME
sudo usermod -aG sudo $USERNAME
echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/$USERNAME

echo "User $USERNAME has been created, added to sudo, and SSH is configured."

