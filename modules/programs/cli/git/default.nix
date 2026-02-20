{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
# INFO:
# use gcl, ga, gs for git
# it is all abbreviations for fish

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  environment.systemPackages = [ pkgs.onefetch ];

  programs.git.package = mkDefault pkgs.gitMinimal;

  hm.programs.git = {
    enable = true;

    package = pkgs.gitMinimal;

    settings = {
      gpg.format = "ssh";

      user = {
        name = "azixz";
        email = "xfalwa@gmail.com";
        signingkey = "${config.hm.home.homeDirectory}/.ssh/id_ed25519.pub";
      };

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

      alias = import ./aliases.nix;
    };
  };
}
