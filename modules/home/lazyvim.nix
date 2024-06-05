{ config, lib, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    plugins = (with pkgs.vimPlugins;
      [
        LazyVim
      ]);
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  home.packages = [ pkgs.nodejs ];   # Used by copilot
}
