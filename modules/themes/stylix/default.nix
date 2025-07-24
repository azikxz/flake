{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  color =
    if mac "pcRyazenka" then
      "breeze"
    else if mac "thinkpadT14" then
      "paleorange"
    else
      "adwaita";
in

mkIf (mac' "isoXtended") {
  hm.stylix = {
    enable = true;

    iconTheme = {
      enable = true;

      dark = "Papirus-Dark";
      light = "Papirus-Light";

      package = pkgs.papirus-icon-theme;
    };

    targets = {
      cava.rainbow.enable = true;
      hyprland.hyprpaper.enable = true;

      helix.enable = false;
      kde.enable = false;
      mako.enable = false;
      mpv.enable = false;
      qt.enable = false;
      spicetify.enable = false;
      tofi.enable = false;
      waybar.enable = false;

      nixcord.enable = true;
    };
  };

  stylix = {
    enable = true;
    overlays.enable = true;

    image = import ./image.nix {
      inherit
        inputs
        pkgs
        lib
        config
        ;
    };

    base16Scheme = if (style.theme != null) then inputs.base16."${style.theme}" else null;
    polarity = "dark";

    cursor = {
      size = 24;
      name = "GoogleDot-Custom";
      package = pkgs.cursors.google-cursor.override (
        with config.lib.stylix.colors.withHashtag;
        if (mac "thinkpadT14") then
          {
            background_color = base08;
            outline_color = base00;
            accent_color = base08;
          }
        else if (mac "pcRyazenka") then
          {
            background_color = base0E;
            outline_color = base00;
            accent_color = base0E;
          }
        else
          {
            background_color = base00;
            outline_color = base05;
            accent_color = base05;
          }
      );
    };

    fonts =
      rec {
        emoji = {
          package = pkgs.noto-fonts-monochrome-emoji;
          name = "Noto Emoji";
        };

        monospace = with pkgs.nerd-fonts; {
          package = jetbrains-mono;
          name = "JetBrainsMono Nerd Font";
        };

        sansSerif = monospace;

        serif = monospace;
      }
      // {
        sizes = {
          desktop = 10;
          popups = 10;
          applications = 12;
          terminal = 12;
        };
      };

    targets = {
      console.enable = true;
      chromium.enable = true;
      fish.enable = true;

      plymouth = {
        enable = true;

        logoAnimated = true;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    arkpandora_ttf
    corefonts
    liberation_ttf
    noto-fonts
    noto-fonts-cjk-sans
  ];

  nixpkgs.overlays = [
    (final: prev: {
      papirus-icon-theme = prev.papirus-icon-theme.override {
        inherit
          color
          ;
      };
    })
  ];
}
