{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf false {
  hm.programs.zsh = with pkgs; {
    enable = false;

    dotDir = ".config/zsh";
    plugins = import ./plugins.nix {
      inherit
        pkgs
        ;
    };

    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;

    enableCompletion = true;
    completionInit = ''
      autoload -U compinit && compinit
    '';

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "eza"
        "colored-man-pages"
      ];
    };

    zsh-abbr = {
      enable = true;
      abbreviations = {
        s = "sudo";
      };
    };

    initExtra =
      let
        completion = {
          default =
            # zsh
            ''
              zstyle ':completion:*' rehash true
              zstyle ':completion:*' menu select
              zstyle ':completion:*:git-checkout:*' sort false
              zstyle ':completion::complete:*' gain-privileges 1
            '';

          fzf-tab =
            # zsh
            ''
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
          default =
            # zsh
            ''
              autoload -U colors && colors
              setopt sharehistory
              setopt automenu
              setopt nobeep
              fpath=(${zsh-completions}/share/zsh/site-functions $fpath)
            '';
        };
      in
      completion.fzf-tab + settings.default + readFile ./keymap;
  };
}
