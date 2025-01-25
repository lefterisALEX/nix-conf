{ config, pkgs, lib, ... }:
let
  isLinux = pkgs.stdenv.hostPlatform.isLinux;
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
  unsupported = builtins.abort "Unsupported platform";
in
{
  imports = [
   ./fish.nix
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
      ".config/fish/completions".source = lib.mkForce ./fish/completions;
      ".config/fish/functions".source = lib.mkForce ./fish/functions;
      ".config/fish/conf.d".source = lib.mkForce ./fish/conf.d;
    }
    (lib.mkIf isDarwin {
      # ".config/karabiner/karabiner.json".source = lib.mkForce ./karabiner/karabiner.json;

    })
  ];


  home.packages = with pkgs; ([
    # Common packages
    fish
    zsh
    eza
    fzf
    starship
    direnv
    tmux
    wget
    btop
    bat
    htop
    zellij
    kubectl
    yamllint
    lazygit
    chezmoi
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
    unixtools.watch
    viddy
    devbox
    helix
    hcloud
    direnv
    nushell
    tflint
    ginkgo
    go
    yazi
    age
    fnm
  ] ++ lib.optionals isLinux [
    # GNU/Linux packages
  ]
  ++ lib.optionals isDarwin [
    # macOS packages
    nerdfonts
    navi
    iterm2
    pluto
    aws-vault
  ]);

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;
    # Direnv integration for flakes
    direnv.enable = true;
    direnv.nix-direnv.enable = true;
  };
}
