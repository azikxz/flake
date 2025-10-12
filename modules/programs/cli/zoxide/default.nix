{
  lib,
  ...
}:

with lib;
# INFO: i replaced z for cd

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  persist.user.files = [ ".local/share/zoxide/db.zo" ];

  hm.programs.zoxide = {
    enable = true;

    options = [ "--cmd cd" ];
  };
}
