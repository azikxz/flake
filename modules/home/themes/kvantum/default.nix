{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.themes.kvantum;
in

{
  options = {
    module.themes.kvantum = {
      enable = mkBool false;
      icon = mkStr config.stylix.iconTheme.dark;
    };
  };

  config = mkIf cfg.enable (
    let
      repo = pkgs.fetchFromGitHub {
        owner = "bluskript";
        repo = "stylix";
        rev = "5ea12b9d3865ae47e71df66d4fef35f6e1b1ee5d";
        hash = "sha256-Xz102PtwFKfz1y1CL2hmd/iYVfZALeW9QJsTHdCjBaw=";
      };
      kvconfig = config.lib.stylix.colors {
        template = "${repo}/modules/qt/kvconfig.mustache";
        extension = ".kvconfig";
      };
      svg = config.lib.stylix.colors {
        template = "${repo}/modules/qt/kvantum-svg.mustache";
        extension = "svg";
      };
      kvantumPackage = pkgs.runCommandLocal "base16-kvantum" { } ''
        directory="$out/share/Kvantum/Base16Kvantum"
        mkdir --parents "$directory"
        cat ${kvconfig} >>"$directory/Base16Kvantum.kvconfig"
        cat ${svg} >>"$directory/Base16Kvantum.svg"
      '';
    in
    {
      home.packages = with pkgs; [
        # qt5
        libsForQt5.qt5ct
        libsForQt5.qtstyleplugin-kvantum
        # qt6
        qt6Packages.qt6ct
        qt6Packages.qtstyleplugin-kvantum
        kvantumPackage
      ];

      qt = {
        enable = true;
        platformTheme.name = "qtct";
      };

      xdg.configFile =
        let
          qtct = ''
            [Appearance]
            style=kvantum
            icon_theme=${cfg.icon}
          '';
        in
        {
          "Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini { }).generate "kvantum.kvconfig" {
            General.theme = "Base16Kvantum";
          };
          "Kvantum/Base16Kvantum".source = "${kvantumPackage}/share/Kvantum/Base16Kvantum";
          "qt5ct/qt5ct.conf".text = qtct;
          "qt6ct/qt6ct.conf".text = qtct;
        };
    }
  );
}
