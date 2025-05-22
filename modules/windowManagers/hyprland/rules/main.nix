{
  lib,
  config,
  ...
}:

let
  mk = param: lay: "${param}, ${lay}";

  wsSet = [
    "w[t1]"
    "w[tg1]"
    "f[1]"
  ];
in

{
  layerrule = [
    (mk "noanim" "notifications")
    (mk "blur" "launcher")
  ];

  workspace = map (x: "${x}, gapsout:0, gapsin:0") wsSet;

  windowrule =
    (import ./windowrule.nix {
      inherit
        config
        ;
    })
    ++ (lib.flatten (
      map (x: [
        "bordersize 0, floating:0, onworkspace:${x}"
        "rounding 0, floating:0, onworkspace:${x}"
      ]) wsSet
    ));
}
