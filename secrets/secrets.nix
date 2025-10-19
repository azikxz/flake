with builtins;

let
  publicKeys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMlPZZJ+ggqwi1gA68WW61gB9NCHmpgzMgejucn4WiiV" ];

  secretsList = [
    "password"

    "discordo"
    "github"
  ];

  mkKeys = file: {
    "${file}.age" = {
      inherit
        publicKeys
        ;
    };
  };

  foldl =
    f: i: l:
    if l == [ ] then i else foldl f (f i (head l)) (tail l);
in

foldl (a: b: a // b) { } (map mkKeys secretsList)
