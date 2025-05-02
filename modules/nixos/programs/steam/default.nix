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
    protonup
    proton-ge-bin
    steam
    ;
  cfg = config.module.programs.steam;
  extraArgs = "-nochatui -nofriendsui -silent";
  home = config.users.users.${sys.userName}.home;
  steamUnified = (
    optionalAttrs (path.steamUnified != null) {
      STEAM_COMPAT_CLIENT_INSTALL_PATH = home + "/.steam";
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
    impermanence.user.dirs = [
      ".local/share/Steam"
      ".steam"
    ];
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
        extraCompatPackages = [
          (proton-ge-bin.override {
            steamDisplayName = "Proton-GE-unstable";
          })
        ];
        package = steam.override {
          inherit extraArgs;
          extraEnv = {
            MANGOHUD = true;
            OBS_VKCAPTURE = true;
            RADV_TEX_ANISO = 16;
          } // steamUnified;
          extraLibraries =
            pkgs: with pkgs; [
              libxkbcommon
              mesa
              wayland
            ];
        };
      };
    };
    systemd.user.services.steam-autostart = mkIf cfg.autostart {
      wantedBy = [ "graphical-session.target" ];
      serviceConfig = {
        ExecStart =
          let
            _ = " ";
          in
          getExe pkgs.steam + _ + extraArgs + _ + "%U";
        Restart = "on-abort";
        RestartSec = "5s";
      };
      environment = { } // steamUnified;
    };
  };
}
