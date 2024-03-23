{ config, pkgs, lib, ... }:
let
  isLinux = pkgs.stdenv.hostPlatform.isLinux;
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
  unsupported = builtins.abort "Unsupported platform";
in
{
  imports = [
    ## Modularize your home.nix by moving statements into other files
  ];

  home.username = "lefteris";
  home.homeDirectory =
    if isLinux then "/home/lefteris" else
    if isDarwin then "/Users/lefteris" else unsupported;

  home.stateVersion = "23.11"; # Don't change this. This will not upgrade your home-manager.
  programs.home-manager.enable = true;
 
  programs.bash = {
    enable = true;
    shellAliases = {
      g = "git";
      lg = "lazygit";
  };
};
  programs.zsh = {
    enable = true;
    shellAliases = {
    g = "git";
    lg = "lazygit";
  };
};

  programs.fish = {
    enable = true;
    shellAliases = {
      g = "git";
      lg = "lazygit";
      lll = "ls -lrth";
    };
    plugins = [
      # Enable a plugin (here grc for colorized command output) from nixpkgs
      { name = "grc"; src = pkgs.fishPlugins.grc.src; }
      # Manually packaging and enable a plugin
      {
        name = "z";
        src = pkgs.fetchFromGitHub {
          owner = "jethrokuan";
          repo = "z";
          rev = "e0e1b9dfdba362f8ab1ae8c1afc7ccf62b89f7eb";
          sha256 = "0dbnir6jbwjpjalz14snzd3cgdysgcs3raznsijd6savad3qhijc";
        };
      }
     { name = "tide"; src = pkgs.fishPlugins.tide; }
     { name = "git"; src = pkgs.fishPlugins.plugin-git; }
    ];
   functions = {
      groot = {
        description = "cd to the root of the current git repository";
        body = ''
          set -l git_repo_root_dir (git rev-parse --show-toplevel 2>/dev/null)
          if test -n "$git_repo_root_dir"
            cd "$git_repo_root_dir"
            echo -e ""
            echo -e "      \e[1m\e[38;5;112m\^V//"
            echo -e "      \e[38;5;184m|\e[37m· ·\e[38;5;184m|      \e[94mI AM GROOT !"
            echo -e "    \e[38;5;112m- \e[38;5;184m\ - /"
            echo -e "     \_| |_/\e[38;5;112m¯"
            echo -e "       \e[38;5;184m\ \\"
            echo -e "     \e[38;5;124m__\e[38;5;184m/\e[38;5;124m_\e[38;5;184m/\e[38;5;124m__"
            echo -e "    |_______|"
            echo -e "     \     /"
            echo -e "      \___/\e[39m\e[00m"
            echo -e ""
          else
            echo "Not in a git repository."
          end
        '';
      };
   };
};
    

  home.packages = with pkgs; ([
    # Common packages
    hello
  ] ++ lib.optionals isLinux [
    # GNU/Linux packages
  ]
  ++ lib.optionals isDarwin [
    # macOS packages
  ]);
}
