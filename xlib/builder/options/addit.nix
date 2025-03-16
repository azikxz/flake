{
  self,
  inputs,
  pkgs,
  lib,
  ...
}:

with lib;
with types;

rec {
  # ylib & stylix
  umport = import ./umport.nix {
    inherit
      lib
      ;
  };
  baseName = filter (path: baseNameOf path == "default.nix");
  mkUmport =
    path: exclude:
    (lib.x.baseName (
      lib.x.umport {
        inherit
          path
          exclude
          ;
      }
    ));

  # enable = true; ++ enable = false;
  on.enable = true;
  off.enable = false;

  # for programs
  toGen = t: e: generators.${toString t} { } e;
  mkGrpOn = l: genAttrs l (n: on);
  mkGrpOff = l: genAttrs l (n: off);
  wm.workspaces =
    with builtins;
    (concatLists (
      genList (
        i:
        let
          ws = i + 1;
        in
        [
          "$mod, code:1${toString i}, workspace, ${toString ws}"
          "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
        ]
      ) 10
    ));
}
// import ./nixpkgs.nix {
  inherit
    self
    inputs
    pkgs
    ;
}
