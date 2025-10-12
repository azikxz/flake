{
  pkgs,
  lib,
  ...
}:

with lib;
# INFO: something like voicechat

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  persist.user.dirs = [
    ".config/Mumble"
    ".local/share/Mumble"
  ];

  hmPackages = [ pkgs.mumble ];
}
