{
  pkgs,
  config,
  ...
}:
pkgs.writeShellApplication {
  name = "walogram";
  runtimeInputs = with pkgs; [
    imagemagick
    file
    zip
  ];
  bashOptions = [ "pipefail" ];
  text =
    let
      inherit (config.xdg) cacheHome;
      inherit (config.stylix) image;
      cfg = config.module.programs.gui.walogram;
      theme = import ./palette.nix { inherit config; };
    in
    # sh
    ''
      # variables
      tempdir="$(mktemp -d)"
      cachedir="${cacheHome}/stylix-telegram-theme"
      themename="stylix.tdesktop-theme"
      walmode="${cfg.walmode}" # solid | background
      blur="true"
      # mkdir 
      mkdir -p "$cachedir"
      echo "${theme}" > "$tempdir/colors.tdesktop-theme"
      gentheme() {
        walname="background.jpg"
        if command -v zip >/dev/null 2>&1; then
          if [ "$walmode" = "solid" ]; then
            magick convert -size 256x256 "xc:''${bgcolor:-''${background:-$color0}}" "$tempdir/$walname"
          else
            case "$(file -b --mime-type "${image}")" in
            image/*) convert ''${blur:+-blur 0x32} -resize 1920x1080 "${image}" "$tempdir/$walname" ;;
            *) echo "not an image: ${image}" ;;
            esac
          fi
          zip -jq -FS "$cachedir/$themename" "$tempdir"/*
        else
          msg "'zip' not found. theme generated without background image"
          cp -f "$tempdir/colors.tdesktop-theme" "$cachedir/$themename"
        fi
      }
      gentheme
    '';

}
