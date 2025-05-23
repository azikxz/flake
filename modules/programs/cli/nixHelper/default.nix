{
  lib,
  ...
}:

with lib;

mkIf (itIs == "desktop" || itIs == "laptop") {
  environment = {
    variables.NH_FLAKE = paths.flakeDir;

    shellAliases = {
      goToFlake = "cd ${paths.flakeDir}";
      rebuild = "nh os switch -H ${machineName}";
      nixRepl = "nh os repl -H ${machineName}";
    };
  };

  programs.nh = {
    enable = true;
    clean.enable = true;

    flake = paths.flakeDir;
  };
}
