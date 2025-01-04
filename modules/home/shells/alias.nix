{
  x,
  lib,
  config,
  ...
}:
with lib;
with x;
let
  cfg = config.module.shells.alias;
in
{
  options = {
    module.shells.alias = {
      alias = mkOpt.attrs.str;
    };
  };

  config = {
    home = {
      shellAliases = cfg.alias;
    };
    xdg.configFile."lutgen/paradise".text =
      "151515 1F1F1F 2E2E2E 424242 BBB6B6 E8E3E3 E8E3E3 E8E3E3 B66467 D9BC8C D9BC8C 8C977D 8AA6A2 8DA3B9 A988B0 BBB6B6";
  };
}
