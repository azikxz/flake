{
  lib,
  ...
}:

with lib;
# INFO: see shellAliases

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  environment.shellAliases = {
    rebuild = "nh os switch --diff always -H ${machine}";
    repl = "nixos-rebuild repl --flake ${paths.flakeDir}#${machine}";
  };

  programs.nh = {
    enable = true;
    clean.enable = true;

    flake = paths.flakeDir;
  };
}
