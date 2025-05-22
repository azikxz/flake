{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (itIs == "desktop" || itIs == "laptop") {
  hm = {
    home.packages = [ pkgs.nvtopPackages.amd ];

    programs.btop = {
      enable = true;

      settings = import ./settings.nix;
    };
  };
}
