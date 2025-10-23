{
  lib,
  ...
}:

with lib;
# INFO: saves clipboard even if window closed

mkIf (mac' "isoXtended") {
  hm = {
    services = {
      wl-clip-persist.enable = true;
      cliphist.enable = true;
    };
  };
}
