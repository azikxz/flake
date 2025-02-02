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
          users = [ userName ];
          groups = [ "wheel" ];
          commands = with pkgs; [
            {
              command = "${light}/bin/light";
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
