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
    };
  };

  imports = with inputs; [ stylix.nixosModules.stylix ];
  config = mkIf cfg.enable {
    stylix = on // {
      overlays = on;
      autoEnable = false;
      image = import ./image.nix {
        inherit
          inputs
          pkgs
          lib
          config
          ;
      };
      base16Scheme = inputs.base16."${x.styl.theme}";
      cursor = with pkgs.cursor; {
        size = 24;
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
      fonts =
        let
          mk = package: name: {
            inherit
              name
              package
              ;
          };
          font = n: mk pkgs.nerd-fonts.caskaydia-cove n;
        in
        rec {
          emoji = mk pkgs.noto-fonts-color-emoji "Noto Color Emoji";
          monospace = font "CaskaydiaCove Nerd Font";
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
        console = on;
        chromium = on;
        fish = on;
        plymouth = on // {
          logoAnimated = true;
        };
      };
    };
    environment.systemPackages =
      with pkgs;
      [
        corefonts
        liberation_ttf
        arkpandora_ttf
      ]
      ++ (with nerd-fonts; [ tinos ]);
  };
}
