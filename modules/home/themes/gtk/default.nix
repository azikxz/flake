{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with x;

let
  inherit (config.stylix) targets fonts;
  cfg = targets.gtk;
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

mkIf cfg.enable {
  home.packages = with pkgs; [
    noto-fonts-cjk-sans
    noto-fonts
  ];
  gtk = on // {
    gtk3.extraConfig = extra;
    gtk4.extraConfig = extra;
    font = mkForce {
      size = 12;
      name = fonts.monospace.name;
      package = fonts.monospace.package;
    };
  };
}
