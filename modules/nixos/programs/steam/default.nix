{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  inherit (pkgs)
    stable
    protonup
    proton-ge-bin
    steam
    ;
  cfg = config.module.programs.steam;
in

{
  options = {
    module.programs.steam = {
      enable = mkBool false;
      autostart = mkBool true;
    };
  };

  config =
    mkIf cfg.enable {
      hardware.xone = on;
      programs.fish.shellAbbrs = {
        protonUpdate = getExe protonup + " -y";
        protonRemove = getExe protonup + " -r";
        protonList = getExe protonup + " -l";
      };
      programs = {
        gamescope = on;
        gamemode = on;
        steam = on // {
          protontricks = on;
          gamescopeSession = on;
          remotePlay.openFirewall = true;
          extraCompatPackages = [
            stable.proton-ge-bin
            proton-ge-bin
          ];
          package = steam.override {
            extraEnv = {
              MANGOHUD = true;
              OBS_VKCAPTURE = true;
              RADV_TEX_ANISO = 16;
            };
          };
        };
      };
      systemd.user.services.steam-autostart = mkIf cfg.autostart {
        wantedBy = [ "graphical-session.target" ];
        serviceConfig = {
          ExecStart = getExe pkgs.steam + " -nochatui -nofriendsui -silent %U";
          Restart = "on-abort";
          RestartSec = "5s";
        };
      };
    }
    // optionalAttrs (path.steamUnified != null) {
      environment.variables.STEAM_COMPAT_DATA_PATH = path.steamUnified;
    };
}
