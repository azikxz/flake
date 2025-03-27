{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  inherit (pkgs) protonup proton-ge-bin steam;
  cfg = config.module.programs.steam;
in

{
  options = {
    module.programs.steam = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    hardware.xone = on;
    programs.fish.shellAbbrs = {
      protonUpdate = "${getExe protonup} -y";
      protonRemove = "${getExe protonup} -r";
      protonList = "${getExe protonup} -l";
    };
    programs = {
      gamescope = on;
      gamemode = on;
      steam = on // {
        gamescopeSession = on;
        remotePlay.openFirewall = true;
        extraCompatPackages = [ proton-ge-bin ];
        package = steam.override {
          extraEnv = {
            MANGOHUD = true;
            OBS_VKCAPTURE = true;
            RADV_TEX_ANISO = 16;
          };
        };
      };
    };
  };
}
