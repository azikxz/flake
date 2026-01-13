{
  pkgs,
  lib,
  ...
}:

with lib;
# INFO:
# list ur contacts and edit/sync

mkIf (mac "pcRyazenka") {
  hm.programs.khard = {
    enable = true;

    settings = {
      "general" = {
        debug = "no";
        default_action = "list";
        editor = [ "$EDITOR" ];
        merge_editor = getExe pkgs.delta;
      };

      "contact table".display = "first_name";
    };
  };
}
