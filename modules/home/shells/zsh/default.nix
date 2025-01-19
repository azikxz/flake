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
  cfg = config.module.shells.zsh;
  abbrs = config.module.shells.abbrs;
in
{
  options = {
    module.shells.zsh = {
      enable = mkBool;
    };
  };

  config = mkIf cfg.enable {
    programs.zsh =
      with pkgs;
      on
      // {
        # COOL TOOLS YEYE
        syntaxHighlighting = on;
        enableCompletion = true;
        autosuggestion = on;
        # SETS
        dotDir = ".config/zsh";
        completionInit = "autoload -U compinit && compinit";
        # CONFIGURATION
        zsh-abbr = on // {
          abbreviations = abbrs;
        };
        initExtra =
          let
            completion = {
              default = ''
                zstyle ':completion:*' rehash true
                zstyle ':completion:*' menu select
                zstyle ':completion:*:git-checkout:*' sort false
                zstyle ':completion::complete:*' gain-privileges 1
              '';
              fzf-tab = ''
                zstyle ':completion:*' menu no
                zstyle ':fzf-tab:*' fzf-command fzf
                zstyle ':fzf-tab:*' fzf-pad 4
                zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2,gutter:-1 \
                  --height=60% \
                  --margin=0,30%,0,0 \
                  --padding=0 \
                  --no-mouse --border rounded \
                  --prompt "Prompt: " \
                  --pointer "->" \
                  --info hidden
                zstyle ':fzf-tab:*' switch-group '<' '>'
                zstyle ':fzf-tab:*' switch-group F1 F2
                zstyle ':fzf-tab:*' fzf-bindings 'space:accept'
                zstyle ':fzf-tab:*' accept-line enter
                zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always \
                  --icons always \
                  $realpath'
              '';
            };
            settings = {
              default = ''
                autoload -U colors && colors
                setopt sharehistory
                setopt automenu
                setopt nobeep
                fpath=(${zsh-completions}/share/zsh/site-functions $fpath)
              '';
            };
          in
          ''
            # COMPLETION
              ${completion.fzf-tab}
            # ZSH SETTINGS
              ${settings.default}
            # BINDINGS
              ${builtins.readFile ./keymap}
          '';
      };
  };
}
