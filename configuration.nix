{ config, lib, pkgs, ... }:

{
  imports = [
  ];

  avf.defaultUser = "koko";
  system.stateVersion = "26.05";
  nix.settings.experimental-features = ["nix-command" "flakes"];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  avf.enableGraphics = true;
  systemd.services.weston.enable = false;
  systemd.user.services.weston.enable = false;

  services.seatd.enable = true;
  users.users.koko.extraGroups = [ "seat" ];
  console.keyMap = "us";

  systemd.services.greetd.serviceConfig.ExecStartPre = [
  "${pkgs.coreutils}/bin/mkdir -p /run/user/1002"
  "${pkgs.coreutils}/bin/chown koko:koko /run/user/1002"
  "${pkgs.coreutils}/bin/chmod 700 /run/user/1002"
  ];

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd ${pkgs.writeShellScript "hypr-launch" ''
          mkdir -p /run/user/1002
          chown koko:koko /run/user/1002
          chmod 700 /run/user/1002
          export XDG_RUNTIME_DIR=/run/user/1002
          unset WAYLAND_DISPLAY
          unset DISPLAY
          unset MESA_VK_WSI_DEBUG
          export WLR_NO_HARDWARE_CURSORS=1
          export MESA_LOADER_DRIVER_OVERRIDE=virtio_gpu
          export LIBGL_DRIVERS_PATH=/run/opengl-driver/lib/dri
          export LD_LIBRARY_PATH=/run/opengl-driver/lib
          ${config.programs.hyprland.package}/bin/Hyprland >> /tmp/hy.log 2>&1
        ''}";
        user = "greeter";
      };
    };
  };


  environment.systemPackages = with pkgs;[
    poppler-utils
    vim
    git
    gcc
    lynx
    surfraw
    waybar
    wofi
    hyprpaper
    wget
    kitty
  ];

  environment.variables = {
    BROWSER="lynx";
  };

  environment.sessionVariables = {
  };

  environment.shellAliases = {
    nixConfig = "sudo vim /etc/nixos/configuration.nix";
    nixBuild = "sudo cd /etc/nixos && sudo nixos-rebuild switch --flake /etc/nixos#yarara";
    Ducknet = "surfraw duckduckgo";
    hyprConfig = "vim ~/.config/hypr/hyprland.conf";
    nixSync = "sudo cd /etc/nixos && git add . && git commit -m 'sync' && git push";
  };
}
