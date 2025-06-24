{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (itIs == "desktop" || itIs == "laptop") {
  environment.systemPackages = [ pkgs.nvtopPackages.amd ];

  hm = {
    home.shellAliases = {
      btop = "btop";
      ntop = "nvtop -i";
    };

    programs.btop = {
      enable = true;

      settings = import ./settings.nix;
    };
  };
}
