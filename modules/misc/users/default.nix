{
  pkgs,
  lib,
  config,
  ...
}:

with lib;

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

        hashedPasswordFile = config.agenix.password;

        description = "nixos system user, owner ${system.hostName} host!";
      };

      root.hashedPasswordFile = config.agenix.password;

      media = {
        isSystemUser = true;

        group = "media";
      };
    };
  };
}
