{
  pkgs,
  config,
  ...
}:

with config.lib.stylix.colors.withHashtag;

pkgs.writeShellApplication {
  name = "walogram";

  runtimeInputs = with pkgs; [
    file
    imagemagick
    zip
  ];

  bashOptions = [ "pipefail" ];

  text =
    let
      theme = import ./palette.nix {
        inherit
          config
          ;
      };
    in
    # sh
    ''
      tempdir="$(mktemp -d)"
      cachedir="${config.hm.xdg.cacheHome}"
      themename="stylix.tdesktop-theme"
      walmode="solid"
      walname="background.jpg"
      blur="true"

      mkdir -p "$cachedir"
      echo "${theme}" > "$tempdir/colors.tdesktop-theme"
      gentheme() {
        if command -v zip >/dev/null 2>&1; then
          if [ "$walmode" = "solid" ]; then
            magick -size 256x256 "gradient:${base01}-${base00}" "$tempdir/$walname"
          else
            case "$(file -b --mime-type "${config.stylix.image}")" in
            image/*) convert ''${blur:+-blur 0x32} -resize 1920x1080 "${config.stylix.image}" "$tempdir/$walname" ;;
            *) echo "not an image: ${config.stylix.image}" ;;
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
