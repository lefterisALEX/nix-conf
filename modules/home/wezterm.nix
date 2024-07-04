{ config, lib, pkgs, ... }:

{
programs.wezterm = {
  enable = true;
  enableZshIntegration = true;
  enableBashIntegration = true;
  # extraConfig = builtins.readFile ./wezterm/wezterm.lua;
};

}
