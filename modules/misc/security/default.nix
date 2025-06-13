{
  pkgs,
  lib,
  ...
}:

with lib;

{
  security = {
    sudo.enable = false;

    sudo-rs = {
      enable = true;

      execWheelOnly = true;
      wheelNeedsPassword = true;

      extraRules = with pkgs; [
        {
          users = [ lib.system.userName ];

          groups = [ "wheel" ];

          commands = [
            {
              command = lib.getExe' amneziawg-tools "awg-quick";
              options = [ "NOPASSWD" ];
            }
            {
              command = getExe light;
              options = [ "NOPASSWD" ];
            }
            {
              command = getExe' uutils-coreutils-noprefix "tee";
              options = [ "NOPASSWD" ];
            }
          ];
        }
      ];
    };
  };
}
