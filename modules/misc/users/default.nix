{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  hashedPasswordFile = config.sopsnix."password";
in

{
  services.getty = mkForce {
    autologinUser = system.userName;
    greetingLine = "uwu nya " + system.userName;
    autologinOnce = true;
  };

  users = {
    defaultUserShell = if config.programs.fish.enable then pkgs.fish else pkgs.zsh;

    groups = {
      ${system.userName} = { };
      media = { };
    };

    users = {
      ${system.userName} = {
        isNormalUser = true;

        home = "/home/" + system.userName;
        createHome = true;

        openssh.authorizedKeys.keys = import ./sshKeys.nix;

        extraGroups = [
          "audio"
          "input"
          "media"
          "video"

          "adbusers"
          "docker"
          "gamemode"
          "libvirtd"
          "networkmanager"
          "podman"
          "suwayomi"
          "terraria"
          "wheel"

          # torrent
          "deluge"
          "flood"
          "qbittorrent"
          "transmission"
        ];

        inherit
          hashedPasswordFile
          ;

        description = "nixos system user, owner ${system.hostName} host!";
      };

      root = {
        inherit
          hashedPasswordFile
          ;
      };

      media = {
        isSystemUser = true;

        group = "media";
      };
    };
  };
}
