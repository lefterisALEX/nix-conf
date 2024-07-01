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
   #./nvim/vim.nix
   ./tmux/tmux.nix
   ./k9s.nix
    ./bat.nix
   ./lazygit.nix
   ./kitty/kitty.nix
   ./apps.nix
   ./cli.nix
   ./sway.nix
   ./alacritty.nix
   ./navi.nix
   ./zoxide.nix
#   ./zellij.nix
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
   "cheats".source = lib.mkForce ./cheats;
   ".config/nvim".source = lib.mkForce ./nvim; # source https://github.com/josean-dev/dev-environment-files
   ".config/zellij".source = lib.mkForce ./zellij; # source https://github.com/josean-dev/dev-environment-files
   ".config/starship.toml".source = lib.mkForce ./starship/starship.toml.v2;
   ".config/fish/completions".source = lib.mkForce ./fish/completions;
   ".config/fish/functions".source = lib.mkForce ./fish/functions;
   ".config/fish/conf.d".source = lib.mkForce ./fish/conf.d;
   # ".config/fish/completions/asp.fish".source = lib.mkForce ./dotfiles/.config/fish/completions/asp.fish;
   # ".config/fish/functions/asp.fish".source = lib.mkForce ./dotfiles/.config/fish/functions/asp.fish;
   # ".config/fish/functions/aar.fish".source = lib.mkForce ./dotfiles/.config/fish/functions/aar.fish;
   # ".config/fish/functions/acp.fish".source = lib.mkForce ./dotfiles/.config/fish/functions/acp.fish;
   # ".config/fish/functions/agp.fish".source = lib.mkForce ./dotfiles/.config/fish/functions/agp.fish;
   # ".config/fish/conf.d/asp.fish".source = lib.mkForce ./dotfiles/.config/fish/conf.d/asp.fish;
   # ".config/fish/completions/aws.fish".source = lib.mkForce ./dotfiles/.config/fish/completions/aws.fish;
   # ".config/fish/functions/aws.fish".source = lib.mkForce ./dotfiles/.config/fish/functions/aws.fish;
   # ".config/fish/conf.d/aws.fish".source = lib.mkForce ./dotfiles/.config/fish/conf.d/aws.fish;
  };


  home.packages = with pkgs; ([
    # Common packages
    fish
    btop
    htop
    zellij
    kubectl
    krew
    ripgrep
    kubectl 
    kubie
    jq
    fd
    fzf
    unzip
    grc
    sslscan
    k6
    gh
    terraform-ls
    neovim
  ] ++ lib.optionals isLinux [
    # GNU/Linux packages
    #wezterm
  ]
  ++ lib.optionals isDarwin [
    # macOS packages
    helix
  ]);

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;
    # Direnv integration for flakes
    direnv.enable = true;
    direnv.nix-direnv.enable = true;
  };
}
