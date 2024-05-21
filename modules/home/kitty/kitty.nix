{ ... }: {
    programs = {
      kitty = {
        enable = true;
        font = {
          name = "DroidSansM Nerd Font";
          size = 11;
        };
        # settings = {
        #     font_family  =    "Iosevka Nerd Font Mono";
        #     scrollback_lines = 10000;
        #     copy_on_select = "yes";

        # };
        extraConfig = builtins.readFile ./kitty.conf;
        shellIntegration.enableZshIntegration = true;
        # shellIntegration.mode = true;
        theme = "Rosé Pine";
      };
      zsh.shellAliases = {
        kimg = "kitty +kitten icat";
      };
    };
}
