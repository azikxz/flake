{
  pkgs,
  lib,
  ...
}:

with pkgs;
let
  inherit (lib)
    getExe
    ;
  mk = command: always: {
    inherit
      command
      always
      ;
  };
in

[
  (mk "mako" false)
  (mk (getExe autotiling-rs) true)
]
