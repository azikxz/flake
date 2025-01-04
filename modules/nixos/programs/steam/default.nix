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
      enable = mkBool;
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ protonup-qt ];
    hardware.xone = True;
    programs = {
      gamescope = True;
      gamemode = True;
      steam = True // {
        # GAMING
        gamescopeSession = True;
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
