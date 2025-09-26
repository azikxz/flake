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

    inherit (config.stylix)
      image
      base16Scheme
      polarity
      iconTheme
      cursor
      ;

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

    iconTheme = {
      enable = true;

      dark = "Papirus-Dark";
      light = "Papirus-Light";

      package = pkgs.papirus-icon-theme;
    };

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

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.caskaydia-cove;
        name = "CaskaydiaCove Nerd Font Propo";
      };

      sansSerif = {
        package = pkgs.nerd-fonts.caskaydia-cove;
        name = "CaskaydiaCove Nerd Font Propo";
      };

      serif = {
        package = pkgs.nerd-fonts.caskaydia-cove;
        name = "CaskaydiaCove Nerd Font Propo";
      };

      emoji = {
        package = pkgs.nerd-fonts.symbols-only;
        name = "Symbols Only Nerd Font";
      };
    }
    // {
      sizes = {
        desktop = 12;
        popups = 12;
        applications = 14;
        terminal = 14;
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
