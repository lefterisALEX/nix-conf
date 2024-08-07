{ config, pkgs, … }:


{
  environment.systemPackages =
    [
      pkgs.home-manager
    ];

  # Use a custom configuration.nix location.
  # environment.darwinConfig = "$HOME/src/github.com/evantravers/dotfiles/nix-darwin-configuration";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix = {
    package = pkgs.nix;
    settings = {
      "extra-experimental-features" = [ "nix-command" "flakes" ];
    };
  };

  # Create /etc/zshrc that loads the nix-darwin environment.
  # programs = {
  #   gnupg.agent.enable = true;
  #   zsh.enable = true;  # default shell on catalina
  # };
  #
  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # Install fonts
  fonts.fontDir.enable = true;
  fonts.fonts = [
    pkgs.monaspace
  ];

  # Use homebrew to install casks and Mac App Store apps
  homebrew = {
    enable = true;

    casks = [
      "soundsource"
    ];

    masApps = {
      "Drafts" = 1435957248;
    };
  };

}
