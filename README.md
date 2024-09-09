## install NIX (On Non NixOS)

https://nixos.org/download/#nix-install-linux

```
# MacOS
sh <(curl -L https://nixos.org/nix/install)
# Linux
sh <(curl -L https://nixos.org/nix/install) --daemon
```

## Prerequired

```
# On NixOS:
nix-env -iA nixos.git nixos.j
# On Non NixOS:
nix-env -iA nixpkgs.git
nix-env -iA nixpkgs.just
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

https://nix-community.github.io/home-manager/index.xhtml#sec-install-standalone  
https://home-manager-options.extranix.com/  
https://search.nixos.org/packages

## NixOS commands

```
systemctl list-timers
```

## NerdFonts (linux)

```
nix-env -iA nixpkgs.nerdfonts
ln -s /nix/store/*nerdfonts*/share/fonts/* ~/.local/share/fonts/
fc-cache -fv
```
