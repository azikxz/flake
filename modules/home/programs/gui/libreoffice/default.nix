{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.programs.gui.libreoffice;
in

{
  options = {
    module.programs.gui.libreoffice = {
      enable = mkBool false;
      yazi.enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ libreoffice-fresh ];
    programs.yazi.settings = mkIf cfg.yazi.enable {
      opener = {
        office = [
          {
            run = ''libreoffice "$@"'';
            desc = "Open document";
            orphan = true;
          }
        ];
      };
      open.rules = (
        map
          (
            n:
            (name: use: {
              inherit
                name
                use
                ;
            })
              n
              "office"
          )
          [
            "*.odt"
            "*.odp"
            "*.ods"
            "*.doc"
            "*.docx"
            "*.ppt"
            "*.pptx"
            "*.xls"
            "*.xlsx"
          ]
      );
      plugin =
        let
          mk =
            run: list:
            (map (mime: {
              inherit mime run;
            }) list);
        in
        {
          prepend_preloaders = mk "office" [
            "application/openxmlformats-officedocument.*"
            "application/oasis.opendocument.*"
            "application/msword"
            "application/ms-*"
            "*.docx"
          ];
          prepend_previewers = mk "office" [
            "application/openxmlformats-officedocument.*"
            "application/oasis.opendocument.*"
            "application/msword"
            "application/ms-*"
            "*.docx"
          ];
        };
    };
  };
}
