{ config, lib, pkgs, ... }:

{
  home.file = {
   ".config/nvim".source = lib.mkForce ./lazyvim;
};
}
