{
  lib,
  ...
}:

with lib;

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  persist.user.dirs = [ ".mangohud-logs" ];

  hm.programs.mangohud = {
    enable = true;
    enableSessionWide = true;

    settings = {
      preset = 3;

      log_interval = 500;
      output_folder = "$HOME/.mangohud-logs";
    };
  };
}
