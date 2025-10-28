with builtins;

let
  # ssh keys from ~/.ssh/id_ed25519.pub
  # without user@hostname
  #
  # when u add new host u need rekey secrets
  # > agenix -r
  publicKeys = import ./modules/misc/users/sshKeys.nix;

  # INFO: write here files
  # whats need to encrypt ./.
  #
  # agenix -e name.age
  secretsList = (
    map (p: ("secrets/" + p)) [
      "password"
    ]
  );

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
