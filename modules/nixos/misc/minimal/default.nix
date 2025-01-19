{
  x,
  lib,
  config,
  ...
}:
with lib;
with x;
let
  cfg = config.module.misc.minimal;
  nahuy = mkDefault off;
in
{
  options = {
    module.misc.minimal = {
      enable = mkBool;
    };
  };

  config = mkIf cfg.enable {
    programs.command-not-found = nahuy;
    documentation = off // {
      # DISABLE MAN AND GUIDES
      dev = nahuy;
      doc = nahuy;
      info = nahuy;
      man = nahuy;
      nixos = nahuy;
    };
  };
}
