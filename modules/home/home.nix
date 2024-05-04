{ config, pkgs, lib, ... }:
let
  isLinux = pkgs.stdenv.hostPlatform.isLinux;
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
  unsupported = builtins.abort "Unsupported platform";
in
{
  imports = [
   ./zsh.nix
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
   ".bashrc".source = lib.mkForce ./dotfiles/.bashrc;
   ".bash.d".source = lib.mkForce ./dotfiles/.bash.d;
   ".config/fish-nix".source = lib.mkForce ./dotfiles/.config/fish;
  };

  programs.fish.enable = true;
  programs.z-lua = {
    enable = true;
    options = [ "once" "fzf" ];
  };

#  programs.zsh = {
#    enable = true;
#    enableAutosuggestions = true;
#    enableCompletion = false;
#    oh-my-zsh = {
#      enable = true;
#      theme = "robbyrussell";
#      plugins = [
#        "git"
#        "npm"
#        "history"
#        "node"
#        "rust"
#        "deno"
#      ];
#    };
#    autocd = true;
#    dotDir = ".config/zsh";
#};


  home.packages = with pkgs; ([
    # Common packages
    hello
    fish
    kubectl 
    kubie
    neovim
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
