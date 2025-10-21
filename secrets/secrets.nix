with builtins;

let
  # ssh keys from ~/.ssh/id_ed25519.pub
  publicKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMlPZZJ+ggqwi1gA68WW61gB9NCHmpgzMgejucn4WiiV"
  ];

  # INFO: write here files
  # whats need to encrypt ./.
  secretsList = [
    "password"

    "anilibme"
    "discordo"
    "github"
  ];

  # without nixpkgs.lib
  # implementation of genAttrs
  mkKeys = file: {
    "${file}.age" = {
      inherit
        publicKeys
        ;
    };
  };

  foldl =
    f: i: l:
    if (l == [ ]) then i else (foldl f (f i (head l)) (tail l));

  genAttrs = n: foldl (a: b: a // b) { } n;
in

genAttrs (map mkKeys secretsList)
