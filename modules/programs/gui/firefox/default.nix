{
  pkgs,
  lib,
  ...
}:

with lib;
let
  settings = import ./settings.nix;
in
# INFO:
# one of the best browsers ever

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  hm.programs.librewolf = {
    enable = true;

    policies = import ./policies.nix;

    profiles.${system.userName} = {
      settings = settings.profile;

      extensions = {
        force = true;

        packages = import ./extensions.nix {
          inherit
            pkgs
            lib
            ;
        };

        settings = settings.ext;
      };
    };
  };
}
