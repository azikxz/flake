{
  lib,
  config,
  ...
}:

with lib;

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  hm.programs.chawan = {
    enable = true;

    settings = {
      buffer = {
        images = true;
        styling = true;
        autofocus = true;
        cookie = true;
      };

      external = {
        download-dir = config.hm.xdg.userDirs.download;
      };
    };
  };
}
