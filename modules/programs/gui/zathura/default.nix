{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
# INFO:
# pdf/word/pptx viewer

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  hmPackages = [ pkgs.zaread ];

  hm.programs.zathura = {
    enable = true;

    options = {
      guioptions = "none";

      selection-clipboard = "clipboard";
      smooth-scroll = true;

      window-title-home-tilde = true;
      statusbar-home-tilde = true;

      page-right-to-left = true;
      first-page-column = "1:1";

      font = concatStringsSep " " [
        config.stylix.fonts.sansSerif.name
        (toString config.stylix.fonts.sizes.applications)
      ];
    };

    mappings = {
      m = "toggle_page_mode";
    };
  };

  hmMime = mkMime {
    "org.pwmt.zathura-cb.desktop" = [
      "application/pdf"
      "application/x-cbt"
      "application/x-cbr"
      "application/x-cbz"
      "application/epub+zip"
      "application/vnd.comicbook-rar"
      "application/vnd.comicbook+zip"
    ];
  };

  nixpkgs.overlays = [
    (final: prev: {
      zathura = prev.zathura.override {
        useMupdf = true;
      };
    })
  ];
}
