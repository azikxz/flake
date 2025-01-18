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
        "${userName}"
        "@wheel"
      ];
      extra-substituters = x.substituters;
      extra-trusted-public-keys = x.keys;
      builders-use-substitutes = true;
      auto-optimise-store = true;
    };
  };
}
