{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (mac' "isoXtended") {
  environment = {
    systemPackages = with pkgs; [
      killall
      wget
      fff
      helix
    ];

    shellAliases.x = "exit";

    variables = {
      EDITOR = "vim";
    };

    sessionVariables = {
      NIXOS_OZONE_WL = 1;
    };
  };

  programs = {
    adb.enable = true;

    light.enable = mkIf (mac "thinkpadT14") true;
  };
}
