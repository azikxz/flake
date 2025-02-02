{
  x,
  lib,
  config,
  ...
}:
with lib;
with x;
let
  cfg = config.module.services.printing;
in
{
  options = {
    module.services.printing = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    services.printing = on // {
      drivers = with pkgs; [ epson_201207w ];
    };
  };
}
