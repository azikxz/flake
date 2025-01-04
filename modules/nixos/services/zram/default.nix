{
  x,
  lib,
  config,
  ...
}:
with lib;
with x;
let
  cfg = config.module.services.zram;
in
{
  options = {
    module.services.zram = {
      enable = mkBool;
      algo = mkOpt.str;
    };
  };

  config = mkIf cfg.enable {
    zramSwap = True // {
      priority = 1000;
      algorithm = cfg.algo;
      swapDevices = 1;
      memoryPercent = 100;
    };
  };
}
