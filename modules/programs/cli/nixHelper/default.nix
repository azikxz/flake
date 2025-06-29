{
  lib,
  ...
}:

with lib;

mkIf (machine == "pcRyazenka" || machine == "thinkpadT14") {
  environment.shellAliases = {
    goToFlake = "cd ${paths.flakeDir}";
    rebuild = "nh os switch -H ${machine}";
    nixRepl = "nixos-rebuild repl --flake ${paths.flakeDir}#${machine}";
    nixPre = "nix store prefetch-file";
  };

  programs.nh = {
    enable = true;
    clean.enable = true;

    flake = paths.flakeDir;
  };
}
