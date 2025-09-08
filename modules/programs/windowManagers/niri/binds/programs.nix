{
  config,
  mk,
  ...
}:

with config.hm.lib.niri.actions;
let
  m = "Mod";
  s = "Shift";
  a = "Alt";
  c = "Ctrl";
in

[
  (mk "${m}+Return" (spawn "kitty"))
  (mk "${m}+Tab" (spawn "bash" "-c" "tofi-drun | xargs niri msg action spawn --"))

  (mk "${m}+V" (spawn "telegram-desktop"))
  (mk "${m}+${s}+V" (spawn "vesktop"))

  (mk "${m}+B" (spawn "qutebrowser"))
  (mk "${m}+${s}+B" (spawn "keepassxc"))
]
