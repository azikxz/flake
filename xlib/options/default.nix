{
  self,
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

  mkMime =
    assocs:
    lib.pipe assocs [
      (lib.mapAttrsToList (
        prog:
        map (type: {
          "${type}" = prog;
        })
      ))
      lib.flatten
      lib.zipAttrs
    ];

  mkSecrets = {
    sops =
      list: sopsFile:
      lib.genAttrs list (n: {
        owner = lib.system.userName;
        inherit
          sopsFile
          ;
      });
  };

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
