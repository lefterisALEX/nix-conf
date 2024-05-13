# Justfile

secrets-decrypt:
    nix-shell -p sops age --run  "export SOPS_AGE_KEY_FILE=./age.key && sops -d modules/home/work.fish.enc > /tmp/work.fish"

# Command to switch system configuration for NixOS
system-nixos:
    sudo nixos-rebuild --flake .#nixos switch

# Do not use
system-mac:
    nix run . -- switch --flake .

# Command to switch Home Manager configuration for Linux with experimental features
home-manager-server:
    home-manager switch --flake .#server --extra-experimental-features 'nix-command flakes' --impure

home-manager-linux:
    home-manager switch --flake .#linux --extra-experimental-features 'nix-command flakes' --impure

# Command to switch Home Manager configuration for MAC
home-manager-mac:
    home-manager switch --flake .#lefteris --extra-experimental-features 'nix-command flakes' --impure

