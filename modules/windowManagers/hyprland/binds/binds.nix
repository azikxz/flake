{
  pkgs,
  lib,
  config,
  ...
}:

let
  mk =
    mod: args: cmd:
    "${toString mod} ${toString args}, ${toString cmd}";

  m = mk "$m,     ";
  s = mk "$m  $s, ";
  a = mk "$m  $a, ";
in

[
  (m "space" "togglefloating")
  (a "space" "centerwindow")

  # window control
  (m "q" "killactive")
  (s "q" "$ex, hyprctl kill")
  (m "f" "fullscreen")

  (m "x" "pseudo")
  (s "x" "pin")

  (m "w" "cyclenext")
  (s "w" "swapnext")

  # window movement
  (m "c" "changegroupactive")
  (m "g" "togglegroup")
  (s "g" "moveoutofgroup")

  # special workspaces
  (m "a" "togglespecialworkspace,  extra")
  (s "a" "movetoworkspace, special:extra")
  (m "d" "togglespecialworkspace,  magic")
  (s "d" "movetoworkspace, special:magic")

  # chsnge workspaces via mouse wheel
  (mk "$m," "next" "workspace, e+1")
  (mk "$m," "prior" "workspace, e-1")

  # notifications
  (m "mouse:275" "$ex, makoctl dismiss -a")
  (s "mouse:275" "$ex, makoctl restore")
]
++ (
  let
    inherit (config.hm.xdg.userDirs.extraConfig) XDG_SCREENSHOTS_DIR;
    pic = "${XDG_SCREENSHOTS_DIR}/$(date +'scr_%d-%m-%y_%H:%M:%S.png')";
  in
  [
    # screenshot
    (mk null null "print, $ex, ${lib.getExe pkgs.grilurp} copysave area   " + pic)
    (mk null "$s" "print, $ex, ${lib.getExe pkgs.grilurp} copysave output " + pic)
  ]
)
++ (import ./programs.nix)
++ (builtins.concatLists (
  builtins.genList (
    i:
    let
      ws = i + 1;
    in
    [
      "$m,    code:1${toString i}, workspace,       ${toString ws}"
      "$m $s, code:1${toString i}, movetoworkspace, ${toString ws}"
    ]
  ) 10
))
