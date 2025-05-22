{
  lib,
  ...
}:

rec {
  on.enable = true;
  off.enable = false;

  umport = import ./umport.nix {
    inherit
      lib
      ;
  };

  mkUmport =
    path: exclude:
    ((lib.filter (path': baseNameOf path' == "default.nix")) (umport {
      inherit
        path
        exclude
        ;
    }));
}
// import ./options.nix {
  inherit
    lib
    ;
}
