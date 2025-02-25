a@{
  inputs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.programs.cli.tgt;
in

{
  options = {
    module.programs.cli.tgt = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ inputs.xpk.tgt ];
    home.file = {
      ".tgt/config/app.toml".text = import ./conf_nix/app.nix;
      ".tgt/config/theme.toml".text = import ./conf_nix/theme.nix { inherit config; };
      ".tgt/config/logger.toml".text = import ./conf_nix/logger.nix;
      ".tgt/config/keymap.toml".text = import ./conf_nix/keymap.nix;
      ".tgt/config/telegram.toml".text = import ./conf_nix/telegram.nix { inherit lib; };
    };
  };
}
