{
  lib,
  ...
}:

with lib;
# INFO:
# beauty visualizer

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  hm.programs.cava.enable = true;
}
