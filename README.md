## install
```
sh <(curl -L https://nixos.org/nix/install)
nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
```


sudo nixos-rebuild --flake .#nixos switch  
home-manager switch --flake .#linux  
home-manager switch --flake .#linux  --extra-experimental-features 'nix-command flakes'

## MACOS
### install
https://nixos.org/download/  
```
sh <(curl -L https://nixos.org/nix/install)
```

### Run
```
nix run . -- build --flake .
nix run . -- switch --flake .
```


sources:
https://github.com/HariSekhon/DevOps-Bash-tools/tree/master
