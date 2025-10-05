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

    users =
      let
        passwd = "$2b$05$vfFJcNMZaHujKhPSERV/o.nLa2GqYlM0e8ovlfwnhj4XdOJ3Gv7h2";
      in
      {
        ${system.userName} = {
          isNormalUser = true;

          home = "/home/" + system.userName;
          createHome = true;

          extraGroups = [
            "audio"
            "input"
            "media"
            "video"
            #
            "adbusers"
            "docker"
            "gamemode"
            "libvirtd"
            "networkmanager"
            "podman"
            "terraria"
            "wheel"
            # torrent
            "deluge"
            "flood"
            "qbittorrent"
            "transmission"
          ];

          initialHashedPassword = mkForce passwd;

          description = "nixos system user, owner ${system.hostName} host!";
        };

        root.initialHashedPassword = mkForce passwd;

        media = {
          isSystemUser = true;

          group = "media";
        };
      };
  };
}
