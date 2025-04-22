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
  steamUnified = (
    optionalAttrs (path.steamUnified != null) {
      STEAM_COMPAT_CLIENT_INSTALL_PATH = config.users.users.nixzoid.home + "/.steam";
      STEAM_COMPAT_DATA_PATH = path.steamUnified;
    }
  );
in

{
  options = {
    module.programs.steam = {
      enable = mkBool false;
      autostart = mkBool true;
    };
  };

  config = mkIf cfg.enable {
    hardware.xone = on;
    programs = {
      fish.shellAbbrs = mkIf config.programs.fish.enable {
        protonUpdate = getExe protonup + " -y";
        protonRemove = getExe protonup + " -r";
        protonList = getExe protonup + " -l";
      };
      gamescope = on;
      gamemode = on;
      steam = on // {
        protontricks = on;
        gamescopeSession = on;
        remotePlay.openFirewall = true;
        extraCompatPackages =
          let
            mk = n: {
              steamDisplayName = "Proton-GE-" + n;
            };
          in
          [
            (proton-ge-bin.override (mk "unstable"))
            (stable.proton-ge-bin.override (mk "stable"))
          ];
        package = steam.override {
          extraArgs = "-nochatui -nofriendsui -silent";
          extraEnv = {
            MANGOHUD = true;
            OBS_VKCAPTURE = true;
            RADV_TEX_ANISO = 16;
          } // steamUnified;
        };
      };
    };
    systemd.user.services.steam-autostart = mkIf cfg.autostart {
      wantedBy = [ "graphical-session.target" ];
      serviceConfig = {
        ExecStart = getExe pkgs.steam;
        Restart = "on-abort";
        RestartSec = "5s";
      };
      environment = { } // steamUnified;
    };
  };
}
