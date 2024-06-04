{ ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        size = 12.0;
        normal = {
          family = "FiraCode Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "FiraCode Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "FiraCode Nerd Font";
          style = "Italic";
        };
      };
      };
    };
}
