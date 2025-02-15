{
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.misc.variables;
in

{
  options = {
    module.misc.variables = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    environment.variables = {
      QT_QPA_PLATFORM = "wayland";
      SDL_VIDEODRIVER = "wayland";
      CLUTTER_BACKEND = "wayland";
      GDK_BACKEND = "wayland";
      NIXPKGS_ALLOW_UNFREE = "1";
      NIXPKGS_ALLOW_INSECURE = "1";
      MOZ_ENABLE_WAYLAND = "1";
      XDG_SESSION_TYPE = "wayland";
      NIXOS_OZONE_WL = "1";
      MOZ_LEGACY_PROFILES = "1";
      QT_QPA_PLATFORMTHEME = "gtk3";
      TDESKTOP_I_KNOW_ABOUT_GTK_INCOMPATIBILITY = "1";
    };
    xdg.terminal-exec.settings = {
      default = [ "kitty.desktop" ];
    };
  };
}
