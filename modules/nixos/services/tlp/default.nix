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
  cfg = config.module.services.tlp;
in
{
  options = {
    module.services.tlp = {
      enable = mkBool;
    };
  };

  config = mkIf cfg.enable {
    services = {
      thermald = on;
      upower = on;
      fprintd = on // {
        # FINGER PRINT
        package = pkgs.fprintd-tod;
        tod = on // {
          driver = pkgs.libfprint-2-tod1-vfs0090;
        };
      };
      tlp = on // {
        settings = {
          PLATFORM_PROFILE_ON_AC = "performance";
          PLATFORM_PROFILE_ON_BAT = "balanced";

          # CPU
          CPU_SCALING_GOVERNOR_ON_AC = "performance";
          CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

          CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
          CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_performance";

          CPU_BOOST_ON_AC = 1;
          CPU_BOOST_ON_BAT = 0;

          CPU_MIN_PERF_ON_AC = 0;
          CPU_MAX_PERF_ON_AC = 100;
          CPU_MIN_PERF_ON_BAT = 0;
          CPU_MAX_PERF_ON_BAT = 40;

          # NETWORKING
          WIFI_PWR_ON_AC = "off";
          WIFI_PWR_ON_BAT = "on";

          # GRAPHICS
          RADEON_DPM_STATE_ON_AC = "performance";
          RADEON_DPM_STATE_ON_BAT = "battery";
          RADEON_POWER_PROFILE_ON_AC = "default";
          RADEON_POWER_PROFILE_ON_BAT = "default";

          # IDK
          TLP_DEFAULT_MODE = "BAT";
          RUNTIME_PM_ON_AC = "auto";
          RUNTIME_PM_ON_BAT = "auto";
          USB_AUTOSUSPEND = 0;
        };
      };
    };
  };
}
