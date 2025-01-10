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
  inherit (lib) getExe;
  cfg = config.module.misc.security;
in
{
  options = {
    module.misc.security = {
      enable = mkBool;
    };
  };

  config = mkIf cfg.enable {
    security.sudo-rs = {
      execWheelOnly = true;
      wheelNeedsPassword = true;
      extraRules = [
        {
          users = [ userName ];
          commands = with pkgs; [
            {
              command = "${getExe light}";
              options = [ "NOPASSWD" ];
            }
            {
              command = "${uutils-coreutils-noprefix}/bin/tee";
              options = [ "NOPASSWD" ];
            }
          ];
        }
      ];
    };
  };
}
