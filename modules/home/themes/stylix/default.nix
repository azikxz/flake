{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.themes.stylix;
in

{
  options = {
    module.themes.stylix = {
      enable = mkBool false;
      icon = mkNull.str null;
      cursor.size = mkInt 24;
    };
  };

  imports = with inputs; [ niri.homeModules.stylix ];
  config = mkIf cfg.enable {
    stylix = on // {
      autoEnable = false;
      cursor = with pkgs.cursor; {
        size = cfg.cursor.size;
        name = "GoogleDot-Custom";
        package =
          let
            mk = a: b: c: {
              background_color = a;
              outline_color = b;
              accent_color = c;
            };
          in
          google-cursor.override (
            with config.lib.stylix.colors.withHashtag;
            if (x.sys.is == "laptop") then
              mk base08 base00 base08
            else if (x.sys.is == "desktop") then
              mk base0E base00 base0E
            else
              mk base00 base05 base05
          );
      };
      iconTheme = on // {
        dark = "Papirus-Dark";
        light = "Papirus-Light";
        package = pkgs.papirus-icon-theme.override {
          color = cfg.icon;
        };
      };
      fonts =
        let
          mk = name: package: { inherit name package; };
        in
        with pkgs;
        rec {
          emoji = mk "Noto Color Emoji" noto-fonts-emoji;
          monospace = mk "JetBrainsMono Nerd Font" nerd-fonts.jetbrains-mono;
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
      targets = import ./targets.nix {
        inherit
          lib
          ;
      };
    };
  };
}
