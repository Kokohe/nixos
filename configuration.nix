{ config, lib, pkgs, ... }:

{
  imports = [
   #  <nixos-avf/avf>
    # include nixos-avf modules
  ];

  avf.defaultUser = "koko";
  system.stateVersion = "26.05";
  programs.hyprland.enable = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];

  environment.systemPackages = with pkgs;[
    vim
    git
    gcc
    lynx
    surfraw
  ];

  environment.variables = {
    BROWSER="lynx";
  };

  environment.shellAliases = {
    nixConfig = "vim /etc/nixos/configuration.nix";
    nixBuild = "cd /etc/nixos && sudo nixos-rebuild switch --flake /etc/nixos#yarara && git add . && git commit -m";
    Ducknet = "surfraw duckduckgo";
  };

}
