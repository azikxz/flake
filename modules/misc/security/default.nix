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

      extraRules = mkIf (mac' "isoXtended") (
        with pkgs;
        [
          {
            users = [ lib.system.userName ];

            groups = [ "wheel" ];
            runAs = "root";

            commands = [
              # WARNING: works only by this path
              # with (getExe' pkgs.amneziawg-tools "awg-quick")
              # it doesnt works
              {
                command = "/run/current-system/sw/bin/awg-quick";
                options = [
                  "NOPASSWD"
                  "SETENV"
                ];
              }
              {
                command = "/run/current-system/sw/bin/awg";
                options = [
                  "NOPASSWD"
                  "SETENV"
                ];
              }
              {
                command = getExe pkgs.self'.waybar-awg;
                options = [
                  "NOPASSWD"
                  "SETENV"
                ];
              }
            ]
            ++ [
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

    pam.services =
      genAttrs
        [
          "su"
          "sudo"
          "login"
        ]
        (n: {
          fprintAuth = true;
        });
  };
}
