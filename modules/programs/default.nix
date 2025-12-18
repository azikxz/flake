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
      fff
      helix
      killall
      wget
    ];

    shellAliases.x = "exit";

    variables = {
      EDITOR = "hx";
    };
  };

  programs = {
    adb.enable = true;

    light.enable = mkIf (mac "thinkpadT14") true;
  };
}
