{
  lib,
  ...
}:

with lib;

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  persist.dirs = [ "/var/lib/clamav" ];

  services.clamav = {
    scanner.enable = true;

    updater = {
      enable = true;

      interval = "daily";
      frequency = 3;

      settings = {
        ScriptedUpdates = "no";

        PrivateMirror = [
          "https://clamav-mirror.ru/"
          "https://mirror.truenetwork.ru/clamav/"
          "http://mirror.truenetwork.ru/clamav/"
        ];
      };
    };
  };
}
