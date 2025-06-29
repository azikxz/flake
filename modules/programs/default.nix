{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (machine != "isoXtended") {
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

    light.enable = mkIf (machine == "thinkpadT14") true;
  };
}
