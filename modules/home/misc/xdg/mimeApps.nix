{
  lib,
}:

let
  text = "Helix.desktop";
  image = "swayimg.desktop";
  video = "mpv.desktop";
  audio = "mpv.desktop";
  web = "org.qutebrowser.qutebrowser.desktop";
  pdf = "org.pwmt.zathura.desktop";
  mk = type: list: (lib.genAttrs list (n: type));
in

{
  defaultApplications =
    (mk text [
      "text/plain"
      "text/x-cmake"
      "text/markdown"
      "text/rhtml"
      "text/x-tex"
      "text/x-java"
      "text/x-ruby"
      "inode/x-empty"
      "text/x-python"
      "text/x-readme"
      "text/x-markdown"
      "application/json"
      "application/x-ruby"
      "application/x-yaml"
      "application/x-shellscript"
      "application/x-docbook+xml"
    ])
    // (mk image [
      "image/avif"
      "image/gif"
      "image/heif"
      "image/jpg"
      "image/jpeg"
      "image/jxl"
      "image/png"
      "image/bmp"
      "image/x-eps"
      "image/x-icns"
      "image/x-ico"
      "image/x-portable-bitmap"
      "image/x-portable-graymap"
      "image/x-portable-swayimgmap"
      "image/x-xbitmap"
      "image/x-xswayimgmap"
      "image/tiff"
      "image/x-psd"
      "image/x-webp"
      "image/webp"
      "image/x-tga"
      "image/svg+xml"
    ])
    // (mk video [
      "video/3gp"
      "video/3gpp"
      "video/3gpp2"
      "video/avi"
      "video/divx"
      "video/dv"
      "video/fli"
      "video/flv"
      "video/mp2t"
      "video/mp4"
      "video/mp4v-es"
      "video/mpeg"
      "video/msvideo"
      "video/ogg"
      "video/quicktime"
      "video/vnd.divx"
      "video/vnd.mpegurl"
      "video/vnd.rn-realvideo"
      "video/webm"
      "video/x-avi"
      "video/x-flv"
      "video/x-m4v"
      "video/x-matroska"
      "video/x-mpeg2"
      "video/x-ms-asf"
      "video/x-msvideo"
      "video/x-ms-wmv"
      "video/x-ms-wmx"
      "video/x-ogm"
      "video/x-ogm+ogg"
      "video/x-theora"
      "video/x-theora+ogg"
      "application/x-matroska"
    ])
    // (mk audio [
      "audio/aac"
      "audio/mp4"
      "audio/mpeg"
      "audio/mpegurl"
      "audio/ogg"
      "audio/vnd.rn-realaudio"
      "audio/vorbis"
      "audio/x-flac"
      "audio/x-mp3"
      "audio/x-mpegurl"
      "audio/x-ms-wma"
      "audio/x-musepack"
      "audio/x-oggflac"
      "audio/x-pn-realaudio"
      "audio/x-scpls"
      "audio/x-speex"
      "audio/x-vorbis"
      "audio/x-vorbis+ogg"
      "audio/x-wav"
    ])
    // (mk web [
      "text/html"
      "x-scheme-handler/ftp"
      "application/xhtml+xml"
      "x-scheme-handler/http"
      "x-scheme-handler/https"
      "x-scheme-handler/chrome"
      "application/x-extension-htm"
      "application/x-extension-xht"
      "application/x-extension-html"
      "application/x-extension-shtml"
      "application/x-extension-xhtml"
      "x-scheme-handler/about"
      "x-scheme-handler/unknown"
    ])
    // {
      # office
      "application/pdf" = pdf;
    };
}
