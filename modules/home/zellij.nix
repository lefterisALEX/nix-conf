{ config, lib, pkgs, ... }:

{
      programs.zellij = {
        enable = true;

        settings = {
          theme = "catppuccin-mocha";
          enableZshIntegration = false;
          enableFishIntegration = true;
          default_shell = "fish";
          simplified_ui = true;
          pane_frames = false;
          default_layout = "compact";
        };
      };

}
