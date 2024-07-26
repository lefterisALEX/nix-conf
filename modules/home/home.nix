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
   # ./tmux/tmux.nix
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
   ".config/starship.toml".source = lib.mkForce ./starship/starship.toml;
   ".config/tmux/tmux.conf".source = lib.mkForce ./tmux/tmux.conf;
   ".config/yabai/yabairc".source = lib.mkForce ./yabai/yabairc;
   ".skhdrc".source = lib.mkForce ./skhd/skhdrc;
   ".wezterm.lua".source = lib.mkForce ./wezterm/wezterm.lua;
   ".config/karabiner/karabiner.json".source = lib.mkForce ./karabiner/karabiner.json; # install karabiner manually from https://karabiner-elements.pqrs.org/docs/getting-started/installation/
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
    tmux
    wget 
    btop
    htop
    zellij
    kubectl
    kubernetes-helm
    kubectx
    krew
    ripgrep
    yq
    fx
    kubie
    jq
    fd
    fzf
    unzip
    grc
    sslscan
    k6
    jless
    gh
    terraform-ls
    neovim
    python3
    crane
  ] ++ lib.optionals isLinux [
    # GNU/Linux packages
    #wezterm
  ]
  ++ lib.optionals isDarwin [
    # macOS packages
    helix
    # skhd
  ]);

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;
    # Direnv integration for flakes
    direnv.enable = true;
    direnv.nix-direnv.enable = true;
  };
}
