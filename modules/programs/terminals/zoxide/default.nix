{
  lib,
  ...
}:

with lib;
# INFO:
# i replaced z for cd
# > cd /etc/nixos/machines/pcRyazenka
# > cd pcRyaz<ENTER>

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  persist.user.files = [ ".local/share/zoxide/db.zo" ];

  hm.programs.zoxide = {
    enable = true;

    options = [ "--cmd cd" ];
  };
}
