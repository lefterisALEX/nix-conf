# /etc/nixos/flake.nix
{
  description = "flake for yourHostNameGoesHere";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
        modules = [ 
           (import ./modules/home/home.nix)
          # (import ./modules/shell)
         ];

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
