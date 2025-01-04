{
  x,
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
      enable = mkBool;
    };
  };

  config = mkIf cfg.enable {
    programs.tmux = True // {
      shell = pkgs: "${fish}/bin/fish";
      clock24 = true;
      keyMode = "vi";
      disableConfirmationPrompt = true;
      customPaneNavigationAndResize = true;
      prefix = "C-a";
      shortcut = "a";
      extraConfig = ''
        set -g status-position bottom
        set -g status-style bg=color0
      '';
    };
  };
}
