{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.programs.steam;
in
# WARNING: for unified prefix use
# STEAM_COMPAT_DATA_PATH=/media/disks/fastBitch/UnifiedPrefix %command%

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  persist.user.dirs = [
    ".local/share/Steam"
    ".steam"
  ];

  hardware.xpadneo.enable = true;

  programs = {
    steam = {
      enable = true;
      gamescopeSession.enable = true;

      protontricks.enable = true;

      remotePlay.openFirewall = true;

      extraCompatPackages = [ pkgs.proton-ge-bin ];

      package = pkgs.steam.override {
        # INFO: doenst works with greetd
        # moved to hyprland
        # extraArgs = concatStringsSep " " [
        #   "-nochatui"
        #   "-nofriendsui"
        #   "-silent"
        # ];

        extraEnv = {
          MANGOHUD = config.hm.programs.mangohud.enable;
          OBS_VKCAPTURE = true;
          RADV_TEX_ANISO = 16;
          PROTON_USE_NTSYNC = 1;
        };

        extraPkgs =
          pkgs: with pkgs; [
            config.hm.programs.mangohud.package
          ];

        extraLibraries =
          pkgs: with pkgs; [
            libxkbcommon
            mesa
            wayland
          ];
      };

      platformOptimizations.enable = true;
    };

    gamescope = {
      enable = true;
      capSysNice = true;
    };

    gamemode = {
      enable = true;
      enableRenice = true;
    };
  };

  hm.systemd.user.services.steam = {
    Unit = {
      Description = cfg.package.meta.description;
      After = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = concatStringsSep " " [
        (getExe cfg.package)
        "-nochatui"
        "-nofriendsui"
        "-silent"
      ];

      Type = "simple";
      KillMode = "process";
      Restart = "on-failure";
      RestartSec = 5;
    };

    Install.WantedBy = [ "graphical-session.target" ];
  };

  nixpkgs.overlays = [
    (final: prev: {
      proton-ge-bin = prev.proton-ge-bin.override {
        steamDisplayName = "Proton-GE";
      };
    })
  ];
}
