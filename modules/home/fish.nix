 { pkgs, ... }: { 
 
  programs.fish = {
    enable = true;
 #   shellInit = builtins.readFile ./alias.sh;
    interactiveShellInit = ''
      set fish_greeting
      #eval (zellij setup --generate-auto-start fish | string collect)
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
        ${builtins.readFile ./config.fish }
        ${builtins.readFile ./alias.fish }
        if test -e /Users/lefteris/work-functions;
            source /Users/lefteris/work-functions/work.fish
        end
        '';
      # Import aliases
      #  imports = [ ./shell_aliases.nix ];

    plugins = [
      # Enable a plugin (here grc for colorized command output) from nixpkgs
      { name = "grc"; src = pkgs.fishPlugins.grc.src; }
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
      {
        name = "bobthefisher";
        src = pkgs.fetchFromGitHub {
          owner = "Scrumplex";
          repo = "bobthefisher";
          rev = "f4179a14b087c7fbfc2e892da429adad40a39e44";
          sha256 = "sha256-l1DHSZa40BX2/4GCjm5E53UOeFEnMioWbZtCW14WX6k=";
        };
      }
    ];

    shellAliases = {
      gogit = "cd ~/git";
      "!!" = "eval \\$history[1]";
      lg = "lazygit";
    };
    shellAbbrs = { 
      kt = "stern";
      vi = "nvim";
      vim = "nvim";
      ks = "kubectl --namespace=kube-system";
      "k.events" = "kubectl get events --sort-by='.metadata.creationTimestamp'";
      "k.nodes.select.gpu" = "kubectl get nodes  --selector=nvidia.com/gpu=true";
      "k.nodes.select.ingress" = "kubectl get nodes  --selector=kpn.org/role=ingress";
      #"k.nodes" = 'kubectl get nodes -o=custom-columns=NodeName:.metadata.name,ROLE:.metadata.labels."kpn\.org/role",EC2-type:.metadata.labels."beta\.kubernetes\.io/instance-type",Instance-type:.metadata.labels."kpn\.org/lifecycle",AZ:.metadata.labels."topology\.kubernetes\.io/zone",IP:.metadata..annotations."alpha\.kubernetes\.io/provided-node-ip",CPU:.status.capacity.cpu,Memory:.status.capacity.memory,PODS_number:.status.capacity.pods';
    }; 

};
}
