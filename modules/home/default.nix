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
   ./k9s.nix
   ./bat.nix
   ./lazygit.nix
   # ./kitty/kitty.nix
   ./apps.nix
   ./cli.nix
   ./sway.nix
   ./alacritty.nix
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

  home.file = lib.mkMerge [
    {
      ".functions".source = lib.mkForce ./dotfiles/.functions;
      "cheats".source = lib.mkForce ./cheats;
      ".config/nvim".source = lib.mkForce ./nvim; # source https://github.com/josean-dev/dev-environment-files
      ".config/zellij".source = lib.mkForce ./zellij; # source https://github.com/josean-dev/dev-environment-files
      ".config/navi/config.yaml".source = lib.mkForce ./navi/config.yaml;
      ".config/tmux/tmux.conf".source = lib.mkForce ./tmux/tmux.conf;
      ".skhdrc".source = lib.mkForce ./skhd/skhdrc;
      ".k8s_color".source = lib.mkForce ./k8s_color;
      ".wezterm.lua".source = lib.mkForce ./wezterm/wezterm.lua;
      ".config/fish/completions".source = lib.mkForce ./fish/completions;
      ".config/fish/functions".source = lib.mkForce ./fish/functions;
      ".config/fish/conf.d".source = lib.mkForce ./fish/conf.d;
    }
    (lib.mkIf isDarwin {
      ".config/karabiner/karabiner.json".source = lib.mkForce ./karabiner/karabiner.json;
      ".config/kitty/kitty.conf".source = lib.mkForce ./kitty/kitty.conf;
      ".config/yabai/yabairc".source = lib.mkForce ./yabai/yabairc;
      ".config/aerospace/aerospace.toml".source = lib.mkForce ./aerospace/aerospace.toml;

    })
  ];


  home.packages = with pkgs; ([
    # Common packages
    fish
    tmux
    wget
    btop
    htop
    zellij
    kubectl
    yamllint
    # kubernetes-helm
    kubectx
    drawio
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
    stern
    nodejs_22
    unixtools.watch
    viddy
    devbox
    helix
    hcloud
    direnv
    ginkgo
    go
  ] ++ lib.optionals isLinux [
    # GNU/Linux packages
  ]
  ++ lib.optionals isDarwin [
    # macOS packages
    #raycast
    nerdfonts
    navi
    iterm2
    pluto
    aws-vault
    # kitty
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
