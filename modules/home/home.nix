{ config, pkgs, lib, ... }:
let
  isLinux = pkgs.stdenv.hostPlatform.isLinux;
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
  unsupported = builtins.abort "Unsupported platform";
in
{
  imports = [
    ## Modularize your home.nix by moving statements into other files
  ];

  home.username = "lefteris";
  home.homeDirectory =
    if isLinux then "/home/lefteris" else
    if isDarwin then "/Users/lefteris" else unsupported;

  home.stateVersion = "23.11"; # Don't change this. This will not upgrade your home-manager.
  programs.home-manager.enable = true;

  home.file = {
   ".bashrc".source = lib.mkForce ./dotfiles/.bashrc;
   ".bash.d".source = lib.mkForce ./dotfiles/.bash.d;
   ".config/fish".source = lib.mkForce ./dotfiles/.config/fish;
  };
 # programs.fish = import ../shell/fish.nix { pkgs = pkgs; }; 
  programs.fish.enable = true;

  home.packages = with pkgs; ([
    # Common packages
    hello
    kubectl 
    grc
    just
    sslscan
    k6
  ] ++ lib.optionals isLinux [
    # GNU/Linux packages
  ]
  ++ lib.optionals isDarwin [
    # macOS packages
  ]);
}
