{
  pkgs,
  lib,
  ...
}:

with lib;

{
  security = {
    polkit.enable = true;
    soteria.enable = true;

    sudo.enable = false;
    sudo-rs = {
      enable = true;

      execWheelOnly = true;
      wheelNeedsPassword = true;

      extraRules =
        with pkgs;
        lib.mkIf (lib.machine != "isoXtended") [
          {
            users = [ lib.system.userName ];

            groups = [ "wheel" ];

            commands = [
              {
                command = getExe' amneziawg-tools "awg-quick";
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
