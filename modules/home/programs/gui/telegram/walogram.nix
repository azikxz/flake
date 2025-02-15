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
      inherit (config.lib.stylix.colors.withHashtag) base00 base01;
      theme = import ./palette.nix { inherit config; };
      cfg = config.module.programs.gui.telegram;
    in
    # sh
    ''
      # variables
      tempdir="$(mktemp -d)"
      cachedir="${cacheHome}/stylix-telegram-theme"
      themename="stylix.tdesktop-theme"
      walmode="${cfg.walogram.mode}"
      walname="background.jpg"
      blur="true"
      # mkdir 
      mkdir -p "$cachedir"
      echo "${theme}" > "$tempdir/colors.tdesktop-theme"
      gentheme() {
        if command -v zip >/dev/null 2>&1; then
          if [ "$walmode" = "solid" ]; then
            magick -size 256x256 "gradient:${base01}-${base00}" "$tempdir/$walname"
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
