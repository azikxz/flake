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
      enable = mkBool false;
    };
  };

  imports = with inputs; [ home-manager.nixosModules.home-manager ];
  config = mkIf cfg.enable {
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
        groups.${userName} = { };
        users =
          let
            pass = "$6$i9pgNdhMRKSaq6l8$LN6X8d5315SSKUGuVEQDtmFYq2Gqal5RiAeXPfCFUERAsp1Ncq4cdN3nBO3TnmdvIUBS46fhU3Py0wi0v36R81";
          in
          {
            ${userName} = {
              uid = 1000;
              home = "/home/${userName}";
              createHome = true;
              isNormalUser = true;
              extraGroups = grp;
              initialHashedPassword = pass;
            };
            root.initialHashedPassword = pass;
          };
      };
  };
}
