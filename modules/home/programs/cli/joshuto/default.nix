{
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.programs.cli.joshuto;
in

{
  options = {
    module.programs.cli.joshuto = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    programs.joshuto = on // {
      mimetype = import ./mimetype.nix;
      settings = import ./settings.nix;
      theme = import ./theme.nix { inherit config; };
    };
  };
}
