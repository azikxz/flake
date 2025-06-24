{
  lib,
  ...
}:

with lib;

mkIf (itIs == "desktop" || itIs == "laptop") {
  environment.shellAliases = {
    goToFlake = "cd ${paths.flakeDir}";
    rebuild = "nh os switch -H ${machineName}";
    nixRepl = "nixos-rebuild repl --flake ${paths.flakeDir}#${machineName}";
    nixPre = "nix store prefetch-file";
  };

  programs.nh = {
    enable = true;
    clean.enable = true;

    flake = paths.flakeDir;
  };
}
