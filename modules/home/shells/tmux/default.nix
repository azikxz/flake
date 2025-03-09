{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.shells.tmux;
in

{
  options = {
    module.shells.tmux = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    programs.tmux = on // {
      shell = getExe fish;
      clock24 = true;
      keyMode = "vi";
      disableConfirmationPrompt = true;
      customPaneNavigationAndResize = true;
      prefix = "C-a";
      shortcut = "a";
      extraConfig = # sh
        ''
          set -g status-position bottom
          set -g status-style bg=color0
        '';
    };
  };
}
