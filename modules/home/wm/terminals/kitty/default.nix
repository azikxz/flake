{
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.wm.terminals.kitty;
in

{
  options = {
    module.wm.terminals.kitty = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    programs.kitty = on // {
      keybindings = import ./binds.nix;
      extraConfig = import ./extraBinds.nix;
      settings = import ./settings.nix // import ./colors.nix { inherit config; };
    };
  };
}
