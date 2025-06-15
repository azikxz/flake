{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (itIs == "desktop" || itIs == "laptop") {
  environment.systemPackages = [ pkgs.nvtopPackages.amd ];

  hm.programs.btop = {
    enable = true;

    settings = import ./settings.nix;
  };
}
