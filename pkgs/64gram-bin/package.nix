{ pkgs }:

let
  telegram = pkgs.stdenv.mkDerivation rec {
    pname = "64gram-bin";
    version = "1.1.55";
    src = pkgs.fetchzip {
      url = "https://github.com/TDesktop-x64/tdesktop/releases/download/v${version}/64Gram_${version}_linux.zip";
      hash = "sha256-eZUWc3utEeyCpHnmlOJl2yugHhuWYkHAI0O79cGCjQ4=";
      stripRoot = false;
    };
    buildPhase = ''
      mkdir -p $out/bin
      cp Telegram $out/bin/telegram-desktop
    '';
  };
in
(pkgs.buildFHSEnv (
  pkgs.appimageTools.defaultFhsEnvArgs
  // {
    inherit (telegram)
      pname
      version
      ;
    targetPkgs =
      pkgs:
      (with pkgs; [
        gtk3
        webkitgtk_4_1
        glib-networking
      ]);
    runScript = pkgs.writeShellScript "64gram-wrapper" ''
      export GIO_MODULE_DIR=/usr/lib/gio/modules/
      export QT_WAYLAND_DISABLED_INTERFACES=wp_fractional_scale_manager_v1
      exec ${telegram}/bin/telegram-desktop "$@"
    '';
  }
))
