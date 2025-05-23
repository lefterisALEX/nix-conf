{ config, pkgs, lib, ... }:
let
  isLinux = pkgs.stdenv.hostPlatform.isLinux;
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
in
{
  programs.fish = {
    enable = true;
 #   shellInit = builtins.readFile ./alias.sh;
    interactiveShellInit = ''
      set fish_greeting
      #eval (zellij setup --generate-auto-start fish | string collect)
      direnv hook fish | source
      starship init fish | source
    '';
    shellInit = 
        ''
        set -g theme_color_scheme dracula
        set -g theme_display_aws_vault_profile yes
        set -g theme_display_k8s_context yes
        set -g theme_display_k8s_namespace yes
        set -g theme_display_date no
        set -g theme_nerd_fonts "yes"
        set -g theme_newline_cursor yes
        set -g direnv_fish_mode disable_arrow
        set -Ux EDITOR nvim
        set -gx PATH /Users/lefteris/.nix-profile/bin $PATH
        ${builtins.readFile ./config.fish }
        ${builtins.readFile ./alias.fish }
        if test -e /Users/lefteris/work-functions;
            source /Users/lefteris/work-functions/work.fish
        end
        if test -e /home/lefteris/work-functions;
            source /home/lefteris/work-functions/tcl.fun
        end

        # Conditionally add Homebrew environment setup if on macOS
        ${lib.optionalString isDarwin ''
          eval "$(/opt/homebrew/bin/brew shellenv)"
        ''}

        '';
      # Import aliases
      #  imports = [ ./shell_aliases.nix ];

    plugins = [
      # Enable a plugin (here grc for colorized command output) from nixpkgs
      # { name = "grc"; src = pkgs.fishPlugins.grc.src; }
      #{ name = "tide"; src = pkgs.fishPlugins.tide.src; }
      # Manually packaging and enable a plugin
#      {
#        name = "z";
#        src = pkgs.fetchFromGitHub {
#          owner = "jethrokuan";
#          repo = "z";
#          rev = "e0e1b9dfdba362f8ab1ae8c1afc7ccf62b89f7eb";
#          sha256 = "0dbnir6jbwjpjalz14snzd3cgdysgcs3raznsijd6savad3qhijc";
#        };
#      }
      #{
      #  name = "bobthefisher";
      #  src = pkgs.fetchFromGitHub {
      #    owner = "Scrumplex";
      #    repo = "bobthefisher";
      #    rev = "f4179a14b087c7fbfc2e892da429adad40a39e44";
      #    sha256 = "sha256-l1DHSZa40BX2/4GCjm5E53UOeFEnMioWbZtCW14WX6k=";
      #  };
      #}
    ];

    shellAliases = {
      gogit = "cd ~/git";
      "!!" = "eval \\$history[1]";
      lg = "lazygit";
    };
    shellAbbrs = { 
      vi = "nvim";
      v = "nvim";
      vim = "nvim";
      cat = "bat -pP";
      ll  = "eza -la";
      zx = "zellij kill-all-sessions && zellij delete-all-sessions";
      ks = "kubectl --namespace=kube-system";
      ksys = "kubie ns kube-system";
      "k.events" = "kubectl get events --sort-by='.metadata.creationTimestamp'";
      "k.nodes.select.gpu" = "kubectl get nodes  --selector=nvidia.com/gpu=true";
      "k.nodes.select.ingress" = "kubectl get nodes  --selector=kpn.org/role=ingress";
    }; 
  };
}
