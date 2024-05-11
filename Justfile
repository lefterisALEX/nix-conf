# Justfile

secrets-decrypt:
    nix-shell -p sops age --run  "export SOPS_AGE_KEY_FILE=./age.key && sops -d modules/home/work.fish.enc > /tmp/work.fish"

# Command to switch system configuration for NixOS
system-nixos:
    sudo nixos-rebuild --flake .#nixos switch

# Command to switch Home Manager configuration for Linux
home-manager-linux-desktop:
    home-manager switch --flake .#linux

home-manager-linux-server:
    home-manager switch --flake .#server

# Command to switch Home Manager configuration for Linux with experimental features
home-manager-server-with-experimental:
    home-manager switch --flake .#server --extra-experimental-features 'nix-command flakes' --impure

home-manager-linux-with-experimental:
    home-manager switch --flake .#linux --extra-experimental-features 'nix-command flakes' --impure

# Command to switch Home Manager configuration for MAC
home-manager-mac:
    rm -rf ~/.config/fish
    nix run . -- switch --flake .
    rm -rf ~/.config/fish
    ln -s ~/.config/fish-nix/ ~/.config/fish
