{
  self,
  inputs,
  pkgs,
  lib,
  ...
}:

with lib;
with types;

{
  # ylib & stylix
  umport = import ./umport.nix { inherit lib; };
  baseName = filter (path: baseNameOf path == "default.nix");

  # enable = true; ++ enable = false;
  on.enable = true;
  off.enable = false;

  # for programs
  toGen = type: text: generators.${toString type} { } text;
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
// import ./nixpkgs.nix { inherit self inputs pkgs; }
