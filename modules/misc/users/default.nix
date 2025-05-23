{
  pkgs,
  lib,
  config,
  ...
}:

with lib;

{
  services.getty = {
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
            "media"
            "video"
            "audio"
            #
            "networkmanager"
            "wheel"
            "docker"
            "podman"
            "libvirtd"
            "terraria"
            "adbusers"
            # torrent
            "transmission"
            "qbittorrent"
            "deluge"
            "flood"
          ];
          initialHashedPassword = passwd;
        };

        root.initialHashedPassword = passwd;

        media = {
          isSystemUser = true;

          group = "media";
        };
      };
  };
}
