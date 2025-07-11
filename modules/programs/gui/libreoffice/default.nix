{
  pkgs,
  lib,
  config,
  ...
}:

with lib;

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  environment.systemPackages = with pkgs; [
    libreoffice-fresh
    poppler-utils
  ];

  hm.programs.yazi.settings = mkIf config.hm.programs.yazi.enable {
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

        list' = [
          "application/ms-*"
          "application/msword"
          "application/oasis.opendocument.*"
          "application/openxmlformats-officedocument.*"
          "*.docx"
        ];
      in
      {
        prepend_preloaders = mk "office" list';

        prepend_previewers = mk "office" list';
      };
  };
}
