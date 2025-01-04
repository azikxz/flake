{
  x,
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
      enable = mkBool;
      shell = mkOpt.str;
    };
  };

  config = mkIf cfg.enable {
    programs.${cfg.shell} = True;
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
        ];
      in
      {
        # USERS SETS
        defaultUserShell = pkgs.${cfg.shell};
        groups.${userName} = { };
        users = {
          ${userName} = {
            uid = 1000;
            home = "/home/${userName}";
            createHome = true;
            isNormalUser = true;
            extraGroups = grp;
          };
        };
      };
  };
}
