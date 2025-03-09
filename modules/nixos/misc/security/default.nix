{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.misc.security;
in

{
  options = {
    module.misc.security = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    security.sudo-rs = {
      execWheelOnly = true;
      wheelNeedsPassword = true;
      extraRules = [
        {
          users = [ sys.userName ];
          groups = [ "wheel" ];
          commands = with pkgs; [
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
