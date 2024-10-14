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
           (import ./modules/home/default.nix)
           (import ./modules/home/starship.nix)
         ];

        pkgs = import nixpkgs {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
      });

      server = home-manager.lib.homeManagerConfiguration ({
        modules = [ 
           (import ./modules/home/default.nix)
           (import ./modules/home/remote-dev.nix)
           (import ./modules/home/starship-linux.nix)
         ];

        pkgs = import nixpkgs {
          system = "aarch64-linux";
          config.allowUnfree = true;
        };
      });

      lefteris = home-manager.lib.homeManagerConfiguration ({
        modules = [ 
        (import ./modules/home/default.nix)
        (import ./modules/home/starship.nix)
        ];
        pkgs = import nixpkgs {
          system = "aarch64-darwin";
          config.allowUnfree = true;
        };
      });
    };
  };
}
