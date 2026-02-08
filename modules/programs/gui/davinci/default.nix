{
  pkgs,
  lib,
  ...
}:

with lib;
# WARN:
# it will be very very long (6~ gb for 20.0)
# kdenlive is shit

mkIf false {
  persist.user.dirs = [
    ".local/share/DaVinciResolve"
    ".local/state/DaVinciResolve"
  ];

  hmPackages = with pkgs; [ davinci-cracked ];
}
