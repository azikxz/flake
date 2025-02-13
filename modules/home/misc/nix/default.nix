{
  x,
  ...
}:
with x;
{
  nix = {
    settings = {
      warn-dirty = false;
      extra-experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [
        "${sys.userName}"
        "@wheel"
      ];
      extra-substituters = x.nix.substituters;
      extra-trusted-public-keys = x.nix.keys;
      builders-use-substitutes = true;
      auto-optimise-store = true;
    };
  };
}
