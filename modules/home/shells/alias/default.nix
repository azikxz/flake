{
  x,
  lib,
  config,
  ...
}:
with lib;
with x;
let
  cfg = config.module.shells;
in
{
  options = {
    module.shells = {
      alias = mkOpt.attrs.str;
      abbrs = mkOpt.attrs.str;
    };
  };

  config = {
    home.shellAliases = cfg.alias;
    xdg.configFile."lutgen/stylix".text =
      with config.lib.stylix.colors;
      "${base00} ${base01} ${base02} ${base03} ${base04} ${base05} ${base06} ${base07} ${base08} ${base09} ${base0A} ${base0B} ${base0C} ${base0D} ${base0E} ${base0E}";
  };
}
