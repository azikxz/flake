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
    services.auto-cpufreq = True // {
      settings = {
        charger = {
          # AC MODE
          governor = "performance";
          turbo = "auto";
        };
        battery = {
          # BAT MODE
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
