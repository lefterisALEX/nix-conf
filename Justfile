# Justfile

# Command to switch system configuration for NixOS
system-nixos:
    sudo nixos-rebuild --flake .#nixos switch

# Command to switch Home Manager configuration for Linux
home-manager-linux:
    home-manager switch --flake .#linux

# Command to switch Home Manager configuration for Linux with experimental features
home-manager-linux-with-experimental:
    home-manager switch --flake .#linux --extra-experimental-features 'nix-command flakes'

# Command to switch Home Manager configuration for MAC
home-manager-mac:
    rm -rf ~/.config/fish
    nix run . -- switch --flake .
    ln -s ~/.config/fish-nix/ ~/.config/fish
