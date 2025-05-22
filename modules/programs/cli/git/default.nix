{
  pkgs,
  lib,
  ...
}:

with lib;
let
  inherit (pkgs)
    gitMinimal
    onefetch
    ;
in

mkIf (itIs == "desktop" || itIs == "laptop") {
  environment.systemPackages = [ onefetch ];

  programs.git.package = mkDefault gitMinimal;

  hm.programs.git = {
    enable = true;

    package = gitMinimal;

    userName = system.userName;
    userEmail = system.userName + "@" + system.hostName + ".org";

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
