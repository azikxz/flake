{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
# WARNING: for unified prefix use STEAM_COMPAT_DATA_PATH

mkIf (itIs == "desktop" || itIs == "laptop") {
  persist.user.dirs = [
    ".local/share/Steam"
    ".steam"
  ];

  hardware.xpadneo.enable = true;

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
        extraArgs = concatStringsSep " " [
          "-nochatui"
          "-nofriendsui"
          "-silent"
        ];

        extraEnv = {
          MANGOHUD = config.hm.programs.mangohud.enable;
          OBS_VKCAPTURE = true;
          RADV_TEX_ANISO = 16;
          PROTON_USE_NTSYNC = "1";
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
