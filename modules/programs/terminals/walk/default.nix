{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
# INFO:
# ls and cd replacement
# kekw
#
# INFO:
# fuzzy: write word to find file
# escape: exit frokm walk with cd to selected dir
# backspace: for cd ..
# space: for preview dirs/files
# enter: open file/enter to dir

mkIf (config.programs.fish.enable) {
  hm.programs.fish.functions =
    let
      exe = concatStringsSep " " [
        (getExe pkgs.walk)
        "--fuzzy"
        "--with-border"
        "--icons"
        "$argv"
      ];

      inherit (config.lib.stylix.colors.withHashtag)
        base0E
        ;
    in
    {
      lk = {
        description = "Use walk as file manager";
        body = concatStringsSep "\n" [
          "set -x WALK_REMOVE_CMD ${getExe' pkgs.trash-cli "trash-put"}"
          ''set -x WALK_STATUS_BAR "Size() + ' | ' + Mode() + ' | ' + Owner()"''
          ''set -x WALK_MAIN_COLOR "${base0E}"''
          "set loc (${exe}); and cd $loc;"
        ];
      };
    };
}
