{ config, pkgs, lib, ... }:
{
  imports = [
  ];

  home.file = {
   ".config/sway".source = lib.mkForce ./sway;
   ".config/waybar".source = lib.mkForce ./waybar;
  };
}
