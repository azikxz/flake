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

      extraRules = mkIf (machine != "isoXtended") (
        with pkgs;
        [
          {
            users = [ lib.system.userName ];

            groups = [ "wheel" ];

            commands = [
              {
                command = getExe light;
                options = [ "NOPASSWD" ];
              }
              {
                command = getExe' coreutils "tee";
                options = [ "NOPASSWD" ];
              }
            ];
          }
        ]
      );
    };
  };
}
