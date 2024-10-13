## install NIX (On Non NixOS)

https://nixos.org/download/#nix-install-linux

```
# MacOS
sh <(curl -L https://nixos.org/nix/install)
# Linux
sh <(curl -L https://nixos.org/nix/install) --daemon
```

or use https://github.com/DeterminateSystems/nix-installer

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
Uninstall Nix >> https://nix.dev/manual/nix/2.18/installation/uninstall

## NixOS commands

```
systemctl list-timers
```

## Manual Steps

### Linux

```
nix-env -iA nixpkgs.nerdfonts
ln -s /nix/store/*nerdfonts*/share/fonts/* ~/.local/share/fonts/
fc-cache -fv
```

### Macos

#### install brew

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

#### App Store

1. Slack

#### keyboard-maestro

Sync Macros : Open Settins >> Sync Macros >> select the sync film from OneDrive

#### add work functions

git clone git@github.com:lefterisALEX/work-functions.git

#### Session manager plugin for AWS

https://docs.aws.amazon.com/systems-manager/latest/userguide/install-plugin-macos-overview.html

#### How to reset Dock

```
defaults delete com.apple.dock && killall Dock
```
