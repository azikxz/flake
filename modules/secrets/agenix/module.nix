{
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.age.secrets;
in

{
  options = {
    agenix = mkOption {
      description = "Shortcut paths to agenix secrets";

      type = types.attrsOf types.str;
      default = { };
    };
  };

  config = {
    agenix = mapAttrs (name: _: cfg.${name}.path) cfg;
  };
}
