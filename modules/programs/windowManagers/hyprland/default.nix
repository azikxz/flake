{
  pkgs,
  lib,
  config,
  ...
}:

with lib;

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  programs.hyprland.enable = true;

  hm.wayland.windowManager.hyprland = {
    enable = config.programs.hyprland.enable;

    xwayland = {
      enable = true;
    };

    systemd = {
      enable = true;
      variables = [
        "--all"
      ];
    };

    plugins = with pkgs; [
      (stdenv.mkDerivation {
        pname = "split-monitor-workspaces";
        version = "git";

        src = fetchFromGitHub {
          owner = "Duckonaut";
          repo = "split-monitor-workspaces";
          rev = "8f0c875a5ba9864b1267e74e6f03533d18c2bca0";
          hash = "sha256-VR3g2sihYBlfdsqmhsOquZ9GI+ZTErZlasSh+85PDNk=";
        };

        BUILT_WITH_NOXWAYLAND = false;

        nativeBuildInputs = [
          meson
          ninja
          pkg-config
        ];
        buildInputs = [
          hyprland
          pango
          cairo
        ] ++ hyprland.buildInputs;
      })
    ];

    settings =
      {
        plugin = {
          split-monitor-workspaces = {
            count = 10;
            keep_focused = 0;
            enable_notifications = 0;
            enable_persistent_workspaces = 1;
          };
        };
      }
      // (import ./binds/main.nix {
        inherit
          pkgs
          lib
          config
          ;
      })
      // import ./rules/main.nix {
        inherit
          lib
          config
          ;
      }
      // import ./settings.nix {
        inherit
          pkgs
          lib
          config
          ;
      };
  };
}
