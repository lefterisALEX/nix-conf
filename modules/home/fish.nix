{ pkgs, ... }: {
  programs.fish.enable = true;
  programs.z-lua = {
    enable = true;
    options = [ "once" "fzf" ];
  };
};
