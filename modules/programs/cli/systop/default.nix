{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (machine == "pcRyazenka" || machine == "thinkpadT14") {
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
