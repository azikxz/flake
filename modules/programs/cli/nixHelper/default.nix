{
  lib,
  ...
}:

with lib;
# INFO: see shellAliases

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  environment.shellAliases = {
    goToFlake = "cd ${paths.flakeDir}";
    rebuild = "sudo nixos-rebuild --sudo --flake ${paths.flakeDir}#${machine} switch";
    nixRepl = "nixos-rebuild repl --flake ${paths.flakeDir}#${machine}";
    nixPre = "nix store prefetch-file";
  };

  programs.nh = {
    enable = true;
    clean.enable = true;

    flake = paths.flakeDir;
  };
}
