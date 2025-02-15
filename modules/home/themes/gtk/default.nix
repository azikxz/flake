{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with x;

let
  cfg = config.module.themes.gtk;
  font = config.stylix.fonts;
  extra = {
    gtk-application-prefer-dark-theme = 1;
    gtk-xft-antialias = 1;
    gtk-xft-hinting = 1;
    gtk-xft-hintstyle = "hintslight";
    gtk-xft-rgba = "rgb";
    gtk-button-images = 0;
    gtk-menu-images = 0;
    gtk-enable-event-sounds = 1;
    gtk-enable-input-feedback-sounds = 0;
  };
in

{
  options = {
    module.themes.gtk = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
    ];
    gtk = on // {
      gtk3.extraConfig = extra;
      gtk4.extraConfig = extra;
      font = mkForce {
        size = 12;
        name = "${font.monospace.name}";
        package = font.monospace.package;
      };
    };
  };
}
