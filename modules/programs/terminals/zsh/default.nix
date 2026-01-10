{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
# INFO:
# cool shell with big customize

mkIf false {
  hm.programs.zsh = with pkgs; {
    enable = true;

    dotDir = "${config.hm.xdg.configHome}/zsh";
    plugins = import ./plugins.nix {
      inherit
        pkgs
        ;
    };

    history = {
      extended = true;

      ignorePatterns = [
        "rm *"
        "pkill *"
      ];
    };

    historySubstringSearch.enable = true;

    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;

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

    initContent = ''
      zstyle ':completion:*' rehash true
      zstyle ':completion:*' menu select
      zstyle ':completion:*:git-checkout:*' sort false
      zstyle ':completion::complete:*' gain-privileges 1
    ''
    + readFile ./keymap;
  };
}
