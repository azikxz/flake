{
  pkgs,
  lib,
  config,
  ...
}:

with lib;

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  hm = {
    home.packages = [ pkgs.self'.zaread ];

    programs.zathura = {
      enable = true;

      options = {
        guioptions = "none";

        selection-clipboard = "clipboard";
        smooth-scroll = true;

        window-title-home-tilde = true;
        statusbar-home-tilde = true;

        font = concatStringsSep " " [
          config.stylix.fonts.sansSerif.name
          (toString config.stylix.fonts.sizes.applications)
        ];
      };
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
