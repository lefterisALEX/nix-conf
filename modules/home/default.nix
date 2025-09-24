{ config, pkgs, lib, ... }:
let
  isLinux = pkgs.stdenv.hostPlatform.isLinux;
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
  unsupported = builtins.abort "Unsupported platform";
in
{
  imports = [
   # ./fish.nix
   ];

  home.username = "lefteris";
  home.homeDirectory =
    if isLinux then "/home/lefteris" else
    if isDarwin then "/Users/lefteris" else unsupported;

  home.stateVersion = "23.11"; # Don't change this. This will not upgrade your home-manager.

  home.file = lib.mkMerge [
    {
      # ".config/fish/conf.d".source = lib.mkForce ./fish/conf.d;
    }
    (lib.mkIf isDarwin {
    })
  ];


  home.packages = with pkgs; ([
    # Common packages
    just
    fish
    zoxide
    zsh
    eza
    fzf
    starship
    direnv
    wget
    tmux
    btop
    bat
    htop
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
    # neovim
    python3
    crane
    stern
    unixtools.watch
    viddy
    devbox
    hcloud
    direnv
    nushell
    tflint
    ginkgo
    go
    yazi
    age
    hclfmt
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
  };
}
