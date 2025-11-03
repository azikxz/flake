{
  pkgs,
  lib,
  ...
}:

with lib;
# INFO: use gcl, ga, gs for git
# it is all abbreviations for fish

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  environment.systemPackages = [ pkgs.onefetch ];

  programs.git.package = mkDefault pkgs.gitMinimal;

  hm.programs.git = {
    enable = true;

    package = pkgs.gitMinimal;

    userName = "azixz";
    userEmail = "xfalwa@gmail.com";

    extraConfig = {
      color = {
        ui = true;

        diff = {
          commit = "yellow";
          frag = "cyan";
          meta = "yellow";
          new = "green";
          old = "red";
          whitespace = "red reverse";
        };
      };

      init.defaultBranch = "main";
      safe.directory = paths.flakeDir;
    };

    aliases = import ./aliases.nix;
  };
}
