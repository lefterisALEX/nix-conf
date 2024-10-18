{ config, pkgs, lib, ... }:
let
  isLinux = pkgs.stdenv.hostPlatform.isLinux;
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
  unsupported = builtins.abort "Unsupported platform";
in
{
  imports = [
   ./lazygit.nix
   ];

  home.username = "lefteris";
  home.homeDirectory =
    if isLinux then "/home/lefteris" else
    if isDarwin then "/Users/lefteris" else unsupported;

  home.stateVersion = "23.11"; # Don't change this. This will not upgrade your home-manager.
#  programs.home-manager =  {
#     enable = true;
#  };

  home.file = lib.mkMerge [
    {

    }
  ];


  home.packages = with pkgs; ([
  ]);

}
