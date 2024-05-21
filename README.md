## install NIX (On Non NixOS)
```
sh <(curl -L https://nixos.org/nix/install)
```

## Prerequired
```
# On NixOS:
nix-env -iA nixos.git nixos.j
# On Non NixOS: 
nix-env -iA nixpkgs.git nix-env -iA nixpkgs.just
```
On nixOS only edit the `/etc/nixos/configuration.nix` and in imports section include the path to `nixos.nix`  
example:  
```
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      /home/<username>/nix-conf/modules/system/nixos.nix
    ];

```

## Home Manager 
```
nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
```


sources:
https://github.com/HariSekhon/DevOps-Bash-tools/tree/master
