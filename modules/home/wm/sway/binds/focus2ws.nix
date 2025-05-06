{
  sway,
  lib,
  ...
}:

with lib;
let
  inherit (sway)
    modifier
    ;
  mkPreset = pre: data: concatMapAttrs pre data;
in

{
  workspacesAndMove =
    mkPreset
      (key: ws: {
        "${modifier}+${key}" = "workspace ${ws}";
        "${modifier}+Shift+${key}" = "move container to workspace ${ws}";
      })
      (
        (genAttrs ((map toString (lists.range 1 9)) ++ [ "i" ]) toString)
        // {
          "0" = "10";
        }
      );
  moveAndFocus =
    mkPreset
      (key: dir: {
        "${modifier}+${key}" = "focus ${dir}";
        "${modifier}+Shift+${key}" = "move ${dir}";
      })
      {
        H = "left";
        J = "down";
        K = "up";
        L = "right";
        Left = "left";
        Down = "down";
        Up = "up";
        Right = "right";
      };
  resizeWindow =
    let
      mkResize = h: j: k: l: {
        "${modifier}+Ctrl+${h}" = "resize shrink width 10 px or 10 ppt";
        "${modifier}+Ctrl+${j}" = "resize shrink height 10 px or 10 ppt";
        "${modifier}+Ctrl+${k}" = "resize grow height 10 px or 10 ppt";
        "${modifier}+Ctrl+${l}" = "resize grow width 10 px or 10 ppt";
      };
    in
    mkResize "H" "J" "K" "L" // mkResize "Left" "Down" "Up" "Right";
}
