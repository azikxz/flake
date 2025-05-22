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
    if itIs == "desktop" then
      "breeze"
    else if itIs == "laptop" then
      "paleorange"
    else
      "adwaita";
in

{
  hm.stylix = {
    enable = true;
    autoEnable = false;

    iconTheme = {
      enable = true;

      dark = "Papirus-Dark";
      light = "Papirus-Light";

      package = pkgs.papirus-icon-theme.override {
        inherit
          color
          ;
      };
    };

    targets = import ./targets.nix;
  };

  stylix = {
    enable = true;
    autoEnable = false;
    overlays.enable = true;

    image = import ./image.nix {
      inherit
        inputs
        pkgs
        lib
        config
        ;
    };

    base16Scheme = inputs.base16."${style.theme}";

    cursor = {
      size = 24;
      name = "GoogleDot-Custom";
      package = inputs.cursors.packages.${pkgs.system}.google-cursor.override (
        with config.lib.stylix.colors.withHashtag;
        if (itIs == "laptop") then
          {
            background_color = base08;
            outline_color = base00;
            accent_color = base08;
          }
        else if (itIs == "desktop") then
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
          package = pkgs.noto-fonts-emoji;
          name = "Noto Emoji";
        };

        monospace = {
          package = pkgs.nerd-fonts.caskaydia-cove;
          name = "CaskaydiaCove Nerd Font";
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
}
