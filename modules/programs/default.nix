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

    variables = {
      EDITOR = "vim";
    };
  };

  programs = {
    adb.enable = true;

    light.enable = mkIf (itIs == "laptop") true;
  };
}
