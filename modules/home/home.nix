{ config, pkgs, lib, ... }:
let
  isLinux = pkgs.stdenv.hostPlatform.isLinux;
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
  unsupported = builtins.abort "Unsupported platform";
in
{
  imports = [
   ./zsh.nix
   ./fish.nix
   ./vim.nix
   ./tmux.nix
   ./k9s.nix
   ./apps.nix
  ];

  home.username = "lefteris";
  home.homeDirectory =
    if isLinux then "/home/lefteris" else
    if isDarwin then "/Users/lefteris" else unsupported;

  home.stateVersion = "23.11"; # Don't change this. This will not upgrade your home-manager.
#  programs.home-manager =  {
#     enable = true;
#  };
  home.file = {
   ".functions".source = lib.mkForce ./dotfiles/.functions;
   ".config/fish/completions/asp.fish".source = lib.mkForce ./dotfiles/.config/fish/completions/asp.fish;
   ".config/fish/functions/asp.fish".source = lib.mkForce ./dotfiles/.config/fish/functions/asp.fish;
   ".config/fish/conf.d/asp.fish".source = lib.mkForce ./dotfiles/.config/fish/conf.d/asp.fish;
  };



  home.packages = with pkgs; ([
    # Common packages
    hello
    fish
    kubectl 
    kubie
    jq
    fzf
    unzip
    grc
    sslscan
    k6
  ] ++ lib.optionals isLinux [
    # GNU/Linux packages
  ]
  ++ lib.optionals isDarwin [
    # macOS packages
  ]);

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;
    # Direnv integration for flakes
    direnv.enable = true;
    direnv.nix-direnv.enable = true;
  };
}
