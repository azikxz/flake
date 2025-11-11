{
  pkgs,
  lib,
  ...
}:

with lib;
# INFO:
# watch system status
# CPU, RAM, netwwork, GPU...

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  hmPackages = [ pkgs.nvtopPackages.amd ];

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
