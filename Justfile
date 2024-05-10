# Justfile

secrets-setup:
    mkdir secrets
    touch secrets/age-key.txt
    echo "add the age key in secrets/age-key"

secrets-decrypt:
    nix-shell -p sops age --run  "export SOPS_AGE_KEY_FILE=./age.key && sops -d modules/home/work.fish.enc > module/home/work.fish "

# Command to switch system configuration for NixOS
system-nixos:
    sudo nixos-rebuild --flake .#nixos switch

# Command to switch Home Manager configuration for Linux
home-manager-linux:
    home-manager switch --flake .#linux

# Command to switch Home Manager configuration for Linux with experimental features
home-manager-linux-with-experimental:
    #rm -rf ~/.config/fish
    home-manager switch --flake .#linux --extra-experimental-features 'nix-command flakes'
    #rm -rf ~/.config/fish
    #ln -s ~/.config/fish-nix/ ~/.config/fish

# Command to switch Home Manager configuration for MAC
home-manager-mac:
    rm -rf ~/.config/fish
    nix run . -- switch --flake .
    rm -rf ~/.config/fish
    ln -s ~/.config/fish-nix/ ~/.config/fish
