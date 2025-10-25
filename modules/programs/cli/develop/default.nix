{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
# INFO: use for nix develop

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  persist.user.dirs = [ ".config/hut" ];

  hmPackages = attrValues {
    inherit (pkgs)
      hut
      nix-init
      ;
  };

  packages = attrValues {
    inherit (pkgs)
      cachix
      nix-tree
      nurl
      ;
  };

  environment.interactiveShellInit = ''
    export CACHIX_AUTH_TOKEN="$(cat ${config.sopsnix."tokens/cachix"})"
  '';
}
