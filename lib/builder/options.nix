{
  self,
  pkgs,
  lib,
  ...
}:

with lib;
with types;

{
  # ylib & stylix
  customPkgs = name: pkgs.callPackage "${self}/pkgs/${name}";
  umport = import ./umport.nix { inherit lib; };
  baseName = lib.filter (path: baseNameOf path == "default.nix");

  # enable = true; ++ enable = false;
  on.enable = true;
  off.enable = false;

  # for programs
  gen = type: text: lib.generators.${toString type} { } text;
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
// import ./nixpkgs
