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
  nahuy = mkDefault False;
in
{
  options = {
    module.misc.minimal = {
      enable = mkBool;
    };
  };

  config = mkIf cfg.enable {
    programs.command-not-found = nahuy;
    documentation = False // {
      # DISABLE MAN AND GUIDES
      dev = nahuy;
      doc = nahuy;
      info = nahuy;
      man = nahuy;
      nixos = nahuy;
    };
  };
}
