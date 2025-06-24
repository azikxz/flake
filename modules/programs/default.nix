{
  pkgs,
  lib,
  ...
}:

with lib;

{
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
      NIXOS_OZONE_WL = 1;
    };
  };

  programs = {
    adb.enable = true;

    light.enable = mkIf (itIs == "laptop") true;
  };
}
