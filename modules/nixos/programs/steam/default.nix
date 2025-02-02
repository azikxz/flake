{
  x,
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
with lib;
with x;
let
  cfg = config.module.programs.steam;
in
{
  options = {
    module.programs.steam = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ protonup-qt ];
    hardware.xone = on;
    programs = {
      gamescope = on;
      gamemode = on;
      steam = on // {
        # GAMING
        gamescopeSession = on;
        remotePlay.openFirewall = true;
        extraCompatPackages = with pkgs; [ proton-ge-bin ];
        package = pkgs.steam.override {
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
