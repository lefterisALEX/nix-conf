{ config, pkgs, lib, ... }:
let
  isLinux = pkgs.stdenv.hostPlatform.isLinux;
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
  unsupported = builtins.abort "Unsupported platform";
in
{
  imports = [
   ];

  home.stateVersion = "23.11"; # Don't change this. This will not upgrade your home-manager.
#  programs.home-manager =  {
#     enable = true;
#  };

  home.file = lib.mkMerge [
    {
      ".work-functions".source = lib.mkForce ./work-functions;
    }
    (lib.mkIf isDarwin {
    })
  ];


  home.packages = with pkgs; ([
    ginkgo
    awscli2
    fzf
    gnumake
    gcc
    tenv
    go
  ] ++ lib.optionals isLinux [
    # GNU/Linux packages
  ]
  ++ lib.optionals isDarwin [
  ]);

  programs = {
  };
}
