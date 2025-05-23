{
  pkgs,
  lib,
  config,
  ...
}:

{
  # shortcuts
  "$m" = "SUPER";
  "$s" = "SHIFT";
  "$a" = "ALT";
  "$c" = "CTRL";

  "$rt" = "RETURN";
  "$sp" = "SPACE";
  "$tb" = "TAB";

  "$ex" = "exec";

  # binds
  bind = import ./binds.nix {
    inherit
      pkgs
      lib
      config
      ;
  };

  binde = import ./binde.nix {
    inherit
      pkgs
      lib
      ;
  };

  bindm =
    let
      mk =
        mod: args: cmd:
        "${toString mod} mouse:${toString args}, ${cmd}";

      m = mk "$m,   ";
      s = mk "$m $s,";
    in
    [
      # windows manage
      (m "272" "movewindow")
      (s "272" "movewindow")
      (m "273" "resizewindow")
      (s "273" "resizewindow 1")
    ];
}
