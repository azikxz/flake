{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
# WARNING: for unified prefix use
# STEAM_COMPAT_DATA_PATH=/media/disks/... %command%

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

  nixpkgs.overlays = [
    (final: prev: {
      proton-ge-bin = prev.proton-ge-bin.override {
        steamDisplayName = "Proton-GE";
      };
    })
  ];
}
