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
      algo = mkOpt.str;
    };
  };

  config =
    let
      ON = if cfg.algo != null then on else off;
    in
    {
      zramSwap = ON // {
        priority = 1000;
        algorithm = cfg.algo;
        swapDevices = 1;
        memoryPercent = 100;
      };
    };
}
