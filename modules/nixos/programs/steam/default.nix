{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  inherit (pkgs) protonup-qt proton-ge-bin steam;
  cfg = config.module.programs.steam;
in

{
  options = {
    module.programs.steam = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ protonup-qt ];
    hardware.xone = on;
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
