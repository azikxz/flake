{
  inputs,
  pkgs,
  lib,
  ...
}:
let
  def = {
    default = false;
  };
  nulla = {
    default = null;
  };
in
with lib;
with lib.types;
import ./nixpkgs
// {
  stable = inputs.nixpkgs-stable.legacyPackages.x86_64-linux;
  # ylib & stylix
  customPkgs = name: pkgs.callPackage ../pkgs/${name};
  umport = import ./umport.nix { inherit lib; };

  # enable = true; ++ enable = false;
  on.enable = true;
  off.enable = false;
  gen = type: text: lib.generators.${type} { } text;
  workspaces =
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
