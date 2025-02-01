# Justfile

# Command to switch system configuration for NixOS
system-nixos:
    sudo nixos-rebuild  switch --impure

# Command to switch Home Manager configuration for Linux with experimental features
home-manager-server:
    home-manager switch --flake .#server --extra-experimental-features 'nix-command flakes' --impure

home-manager-linux:
    home-manager switch --flake .#linux --extra-experimental-features 'nix-command flakes' --impure

# Command to switch Home Manager configuration for MAC
home-manager-mac:
    zsh -i -c 'home-manager switch --flake .#lefteris --extra-experimental-features "nix-command flakes" --impure'
