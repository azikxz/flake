{
  lib,
  config,
  ...
}:

with lib;
# INFO:
# tui web (very unstable)

mkIf false {
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
