with builtins;

let
  # ssh keys from ~/.ssh/id_ed25519.pub
  # without user@hostname
  #
  # when u add new host u need rekey secrets
  # > agenix -r
  publicKeys = import ./modules/misc/users/sshKeys.nix;

  secretsList =
    (mapExt [
      "password"
    ] "age")

    ++ (mapExt [
      "email"
    ] "toml");

  mapExt = names: ext: map (p: "secrets/" + p + "." + ext) names;

  # without nixpkgs.lib
  # implementation of genAttrs
  mkKeys = file: {
    "${file}" = {
      inherit
        publicKeys
        ;
    };
  };

  foldl =
    f: i: l:
    if l == [ ] then i else foldl f (f i (head l)) (tail l);

  genAttrs = n: foldl (a: b: a // b) { } n;
in

genAttrs (map mkKeys secretsList)
