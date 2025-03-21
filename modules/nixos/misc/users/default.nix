{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.misc.users;
in

{
  options = {
    module.misc.users = {
      passwd = mkStr "$2b$05$vfFJcNMZaHujKhPSERV/o.nLa2GqYlM0e8ovlfwnhj4XdOJ3Gv7h2"; # nixos
      user.passwd = mkStr cfg.passwd;
      root.passwd = mkStr cfg.passwd;
    };
  };

  imports = with inputs; [ home.nixosModules.home-manager ];
  config = {
    programs.fish = on;
    users =
      let
        grp = [
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
      in
      {
        defaultUserShell = pkgs.fish;
        groups.${sys.userName} = { };
        users = {
          ${sys.userName} = {
            uid = 1000;
            home = "/home/${sys.userName}";
            createHome = true;
            isNormalUser = true;
            extraGroups = grp;
            initialHashedPassword = cfg.user.passwd;
          };
          root.initialHashedPassword = cfg.root.passwd;
        };
      };
  };
}
