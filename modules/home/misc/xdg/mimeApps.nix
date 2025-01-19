{ x, ... }:
with x;
let
  ds = "desktop";
in
{
  xdg.mimeApps = on // {
    defaultApplications =
      let
        web = "org.qutebrowser.qutebrowser";
      in
      {
        # TEXT FORMATS
        "text/plain" = "Helix.${ds}";
        "text/x-cmake" = "Helix.${ds}";
        "text/markdown" = "Helix.${ds}";
        "text/rhtml" = "Helix.${ds}";
        "text/x-tex" = "Helix.${ds}";
        "text/x-java" = "Helix.${ds}";
        "text/x-ruby" = "Helix.${ds}";
        "inode/x-empty" = "Helix.${ds}";
        "text/x-python" = "Helix.${ds}";
        "text/x-readme" = "Helix.${ds}";
        "text/x-markdown" = "Helix.${ds}";
        "application/json" = "Helix.${ds}";
        "application/x-ruby" = "Helix.${ds}";
        "application/x-yaml" = "Helix.${ds}";
        "application/x-shellscript" = "Helix.${ds}";
        "application/x-docbook+xml" = "Helix.${ds}";
        # IMAGE FORMATS
        "image/avif" = "swayimg.${ds}";
        "image/gif" = "swayimg.${ds}";
        "image/heif" = "swayimg.${ds}";
        "image/jpg" = "swayimg.${ds}";
        "image/jpeg" = "swayimg.${ds}";
        "image/jxl" = "swayimg.${ds}";
        "image/png" = "swayimg.${ds}";
        "image/bmp" = "swayimg.${ds}";
        "image/x-eps" = "swayimg.${ds}";
        "image/x-icns" = "swayimg.${ds}";
        "image/x-ico" = "swayimg.${ds}";
        "image/x-portable-bitmap" = "swayimg.${ds}";
        "image/x-portable-graymap" = "swayimg.${ds}";
        "image/x-portable-swayimgmap" = "swayimg.${ds}";
        "image/x-xbitmap" = "swayimg.${ds}";
        "image/x-xswayimgmap" = "swayimg.${ds}";
        "image/tiff" = "swayimg.${ds}";
        "image/x-psd" = "swayimg.${ds}";
        "image/x-webp" = "swayimg.${ds}";
        "image/webp" = "swayimg.${ds}";
        "image/x-tga" = "swayimg.${ds}";
        "image/svg+xml" = "swayimg.${ds}";
        # VIDEO FORMATS
        "video/3gp" = "mpv.${ds}";
        "video/3gpp" = "mpv.${ds}";
        "video/3gpp2" = "mpv.${ds}";
        "video/avi" = "mpv.${ds}";
        "video/divx" = "mpv.${ds}";
        "video/dv" = "mpv.${ds}";
        "video/fli" = "mpv.${ds}";
        "video/flv" = "mpv.${ds}";
        "video/mp2t" = "mpv.${ds}";
        "video/mp4" = "mpv.${ds}";
        "video/mp4v-es" = "mpv.${ds}";
        "video/mpeg" = "mpv.${ds}";
        "video/msvideo" = "mpv.${ds}";
        "video/ogg" = "mpv.${ds}";
        "video/quicktime" = "mpv.${ds}";
        "video/vnd.divx" = "mpv.${ds}";
        "video/vnd.mpegurl" = "mpv.${ds}";
        "video/vnd.rn-realvideo" = "mpv.${ds}";
        "video/webm" = "mpv.${ds}";
        "video/x-avi" = "mpv.${ds}";
        "video/x-flv" = "mpv.${ds}";
        "video/x-m4v" = "mpv.${ds}";
        "video/x-matroska" = "mpv.${ds}";
        "video/x-mpeg2" = "mpv.${ds}";
        "video/x-ms-asf" = "mpv.${ds}";
        "video/x-msvideo" = "mpv.${ds}";
        "video/x-ms-wmv" = "mpv.${ds}";
        "video/x-ms-wmx" = "mpv.${ds}";
        "video/x-ogm" = "mpv.${ds}";
        "video/x-ogm+ogg" = "mpv.${ds}";
        "video/x-theora" = "mpv.${ds}";
        "video/x-theora+ogg" = "mpv.${ds}";
        "application/x-matroska" = "mpv.${ds}";
        # AUDIO FORMATS
        "audio/aac" = "mpv.${ds}";
        "audio/mp4" = "mpv.${ds}";
        "audio/mpeg" = "mpv.${ds}";
        "audio/mpegurl" = "mpv.${ds}";
        "audio/ogg" = "mpv.${ds}";
        "audio/vnd.rn-realaudio" = "mpv.${ds}";
        "audio/vorbis" = "mpv.${ds}";
        "audio/x-flac" = "mpv.${ds}";
        "audio/x-mp3" = "mpv.${ds}";
        "audio/x-mpegurl" = "mpv.${ds}";
        "audio/x-ms-wma" = "mpv.${ds}";
        "audio/x-musepack" = "mpv.${ds}";
        "audio/x-oggflac" = "mpv.${ds}";
        "audio/x-pn-realaudio" = "mpv.${ds}";
        "audio/x-scpls" = "mpv.${ds}";
        "audio/x-speex" = "mpv.${ds}";
        "audio/x-vorbis" = "mpv.${ds}";
        "audio/x-vorbis+ogg" = "mpv.${ds}";
        "audio/x-wav" = "mpv.${ds}";
        # WEB
        "text/html" = "${web}.${ds}";
        "x-scheme-handler/ftp" = "${web}.${ds}";
        "application/xhtml+xml" = "${web}.${ds}";
        "x-scheme-handler/http" = "${web}.${ds}";
        "x-scheme-handler/https" = "${web}.${ds}";
        "x-scheme-handler/chrome" = "${web}.${ds}";
        "application/x-extension-htm" = "${web}.${ds}";
        "application/x-extension-xht" = "${web}.${ds}";
        "application/x-extension-html" = "${web}.${ds}";
        "application/x-extension-shtml" = "${web}.${ds}";
        "application/x-extension-xhtml" = "${web}.${ds}";
        "x-scheme-handler/about" = "${web}.${ds}";
        "x-scheme-handler/unknown" = "${web}.${ds}";
        # OTHER
        "x-scheme-handler/spotify" = "spotify.${ds}";
      };
  };
}
