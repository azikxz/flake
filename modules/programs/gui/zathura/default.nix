{
  lib,
  config,
  ...
}:

with lib;

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  hm.programs.zathura = {
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

  nixpkgs.overlays = [
    (final: prev: {
      zathura = prev.zathura.override {
        useMupdf = true;
      };
    })
  ];
}
