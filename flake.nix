# /etc/nixos/flake.nix
{
  description = "flake for yourHostNameGoesHere";


  inputs.nixpkgs = {
    url = "github:nixos/nixpkgs/nixos-23.11";         ## Most stable, less downloads
    # url = "github:nixos/nixpkgs/nixpkgs-unstable";  ## Bleeding edge packages
    # url = "github:nixos/nixpkgs/nixos-unstable";    ## Above, but with nixos tests
  };

  inputs.home-manager = {
    url = "github:nix-community/home-manager/release-23.11";

    ## Track the master branch of Home Manager if you are not on a stable
    ## release
    # url = "github:nix-community/home-manager/master";
    inputs.nixpkgs.follows = "nixpkgs";
  };


  outputs = { self, nixpkgs, home-manager }: {
    defaultPackage.x86_64-darwin = home-manager.defaultPackage.x86_64-darwin;

    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./modules/system/nixos.nix
        ];
      };
    };

    homeConfigurations = {
      linux = home-manager.lib.homeManagerConfiguration ({
        modules = [ (import ./modules/home/home.nix) ];
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
      });
      lefteris = home-manager.lib.homeManagerConfiguration ({
        modules = [ (import ./modules/home/home.nix) ];
        pkgs = import nixpkgs {
          system = "x86_64-darwin";
        };
      });
    };
  };
}
