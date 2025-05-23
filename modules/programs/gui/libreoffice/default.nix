{
  pkgs,
  lib,
  config,
  ...
}:

with lib;

mkIf (itIs == "desktop" || itIs == "laptop") {
  hm = {
    home.packages = with pkgs; [ libreoffice-fresh ];

    programs.yazi.settings = mkIf config.hm.programs.yazi.enable {
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
              inherit
                mime
                run
                ;
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
