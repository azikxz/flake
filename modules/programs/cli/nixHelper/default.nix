{
  lib,
  ...
}:

with lib;
# INFO: see shellAliases

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  environment.shellAliases = {
    rebuild = "nh os switch --diff always -H ${machine}";
    nixRepl = "nixos-rebuild repl --flake ${paths.flakeDir}#${machine}";
    nixPre = "nix store prefetch-file";
  };

  programs.nh = {
    enable = true;
    clean.enable = true;

    flake = paths.flakeDir;
  };
}
