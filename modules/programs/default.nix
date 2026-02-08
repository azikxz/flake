{
  pkgs,
  lib,
  ...
}:

with lib;
# INFO:
# default applicationas

{
  environment = {
    systemPackages = with pkgs; [
      git
      fff
      helix
      killall
      wget
      android-tools
    ];

    shellAliases.x = "exit";

    variables = {
      EDITOR = "hx";
    };
  };

  programs = {
    light.enable = mkIf (mac "thinkpadT14") true;
  };
}
