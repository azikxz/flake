{
  x,
  lib,
  config,
  ...
}:
with lib;
with x;
let
  cfg = config.module.services.autocpu;
in
{
  options = {
    module.services.autocpu = {
      enable = mkBool;
    };
  };

  config = mkIf cfg.enable {
    services.auto-cpufreq = on // {
      settings = {
        charger = {
          governor = "performance";
          turbo = "auto";
        };
        battery = {
          governor = "powersave";
          turbo = "auto";
          energy_perf_bias = "balance_power";
          platform_profile = "low-power";
          enable_thresholds = true;
        };
      };
    };
  };
}
