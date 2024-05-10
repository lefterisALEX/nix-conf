#!/bin/bash

# Define the paths to the old/current and new age key files
SOPS_AGE_KEY_FILE=~/.config/sops/age/keys.txt
SOPS_AGE_KEY_FILE_NEW=./age.key
nix-shell -p sops age --run  "sops -d modules/home/work.fish.enc"
