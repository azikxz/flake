{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  extraArgs = concatStringsSep " " [
    "-bigpicture"
    "-gamepadui"
    "-nochatui"
    "-nofriendsui"
    "-silent"
  ];

  # STEAM_COMPAT_DATA_PATH=${paths.winePrefix} %command%
  steamUnified = (
    optionalAttrs (paths.winePrefix != null) {
      STEAM_COMPAT_CLIENT_INSTALL_PATH = config.hm.home.homeDirectory + "/.steam";
      STEAM_COMPAT_DATA_PATH = paths.winePrefix;
    }
  );
in

mkIf (itIs == "desktop" || itIs == "laptop") {
  persist.user.dirs = [
    ".local/share/Steam"
    ".steam"
  ];

  hardware.xone.enable = true;

  programs = with pkgs; {
    steam = {
      enable = true;
      gamescopeSession.enable = true;

      remotePlay.openFirewall = true;

      extraCompatPackages = [
        (proton-ge-bin.override {
          steamDisplayName = "Proton-GE-unstable";
        })

        (_24.proton-ge-bin.override {
          steamDisplayName = "Proton-GE-stable";
        })
      ];

      package = steam.override {
        inherit
          extraArgs
          ;

        extraEnv = {
          MANGOHUD = true;
          OBS_VKCAPTURE = true;
          RADV_TEX_ANISO = 16;
          PROTON_USE_NTSYNC = "1";
        } // steamUnified;

        extraPkgs =
          pkgs: with pkgs; [
            mangohud
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

      args = [
        "-e"
        "-w 1920"
        "-h 1080"
        "-r 60"
        "--xwayland-count 2"
        "--backend sdl"
      ];
    };

    gamemode = {
      enable = true;
      enableRenice = true;
    };
  };
}
