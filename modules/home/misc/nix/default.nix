{
  lib,
  ...
}:

let
  inherit (lib) x;
in

{
  nix = {
    settings = {
      warn-dirty = false;
      extra-experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [
        x.sys.userName
        "@wheel"
      ];
      extra-substituters = x.nix.subs;
      extra-trusted-public-keys = x.nix.keys;
      builders-use-substitutes = true;
      auto-optimise-store = true;
    };
  };
}
