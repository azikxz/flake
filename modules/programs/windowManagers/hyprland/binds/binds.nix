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

  # (m "bracketright" "changemonitor, next")
  # (m "bracketleft" "changemonitor, prev")
  # (m "backslash" "grabroguewindows")

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
++ (lib.optionals (lib.mac "pcRyazenka") [
  (m "grave" "$ex, wleave")
])
++ (
  let
    inherit (config.hm.xdg.userDirs.extraConfig) XDG_SCREENSHOTS_DIR;
    pic = "${XDG_SCREENSHOTS_DIR}/$(date +'scr_%d-%m-%y_%H:%M:%S.png')";
  in
  [
    # screenshot
    (mk null null "print, $ex, ${lib.getExe pkgs.grimblast} copysave area   " + pic)
    (mk null "$s" "print, $ex, ${lib.getExe pkgs.grimblast} copysave output " + pic)
  ]
)
++ (import ./programs.nix {
  inherit
    pkgs
    lib
    config
    ;
})
++ (builtins.concatLists (
  builtins.genList (
    x:
    let
      key = toString x;
      # key 0 is at the end of the keyboard row
      workspaceNumber = if x == 0 then 10 else x;
    in
    [
      "$m,    ${key}, workspace,       ${toString workspaceNumber}"
      "$m $s, ${key}, movetoworkspace, ${toString workspaceNumber}"
    ]
  ) 10
))
