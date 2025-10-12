{
  pkgs,
  lib,
  ...
}:

rec {
  on.enable = true;
  off.enable = false;

  mac = n: (lib.machine == n);
  mac' = n: (lib.machine != n);

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

  obsidian = import ./obsidianBuilders {
    inherit
      pkgs
      lib
      ;
  };
}
// import ./options.nix {
  inherit
    lib
    ;
}
// import ./syncthing.nix
