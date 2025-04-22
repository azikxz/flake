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
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ libreoffice-fresh ];
    programs.yazi.settings = {
      opener = {
        office = [
          {
            run = ''libreoffice "$@"'';
            desc = "Open document";
            orphan = true;
          }
        ];
      };
      open.rules =
        let
          mk = name: {
            use = [ "office" ];
            inherit
              name
              ;
          };
        in
        map (n: mk n [ "office" ]) [
          "*.odt"
          "*.odp"
          "*.ods"
          "*.doc"
          "*.docx"
          "*.ppt"
          "*.pptx"
          "*.xls"
          "*.xlsx"
        ];
    };
  };
}
