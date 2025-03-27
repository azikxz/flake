{
  inputs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.programs.cosmic;
in

{
  options = {
    module.programs.cosmic = {
      enable = mkBool false;
    };
  };

  imports = with inputs; [ cosmic.nixosModules.default ];
  config = mkIf cfg.enable {
    services.desktopManager.cosmic = on;
  };
}
