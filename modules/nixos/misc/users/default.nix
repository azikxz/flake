{
  x,
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
      passwd = mkStr "$6$T4HzrtblHxoBy.OJ$lHfkK82NM333C93PfFvuZZF0OfxY4.9V74.pKpYMRQiTDxkBYQn/H9Xmo40llzLkJiOauSm6hafGpDoc6AtLw.";
    };
  };

  imports = with inputs; [ home-manager.nixosModules.home-manager ];
  config = {
    programs.fish = on;
    users =
      let
        grp = [
          "video"
          "audio"
          "networkmanager"
          "wheel"
          "docker"
          "podman"
          "libvirtd"
          "terraria"
          "transmission"
          "adbusers"
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
            initialHashedPassword = cfg.passwd;
          };
          root.initialHashedPassword = cfg.passwd;
        };
      };
  };
}
