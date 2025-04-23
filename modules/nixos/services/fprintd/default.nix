{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.services.fprintd;
in

{
  options = {
    module.services.fprintd = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    services.fprintd = on // {
      package = pkgs.stable.fprintd-tod;
      tod = on // {
        driver = pkgs.stable.libfprint-2-tod1-vfs0090;
      };
    };
  };
}
