{
  x,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkIf;
  cfg = config.module.wm.hyprland;
in
{
  wayland.windowManager.hyprland.settings = {
    layerrule = [ "noanim, notifications" ];
    workspace =
      let
        rule = "gapsout:0,  gapsin:0";
        spec = rule + ",  rounding:false,  shadow:false,  bordersize:1";
      in
      mkIf (x.is == "laptop") [
        "w[tv1],   ${rule}"
        "f[1],     ${rule}"
        "s[true],  ${spec}"
      ];
    windowrulev2 = [ ] ++ cfg.rules;
  };
}
