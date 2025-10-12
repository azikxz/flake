{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  persist.user.files = [ ".local/share/fish/fish_history" ];

  programs.fish.enable = true;

  hmPackages = [ pkgs.grc ];

  hm.programs.fish = {
    enable = true;

    preferAbbrs = true;
    shellAbbrs = {
      gai = "git add --intent-to-add";
      gus = "git update-index --skip-worktree --assume-unchanged";
    };

    plugins =
      with pkgs.fishPlugins;
      map
        (p: {
          inherit (p)
            name
            src
            ;
        })
        [
          colored-man-pages
          autopair-fish
          fzf-fish
          git-abbr
          puffer
          grc
        ];

    interactiveShellInit =
      let
        d = "bind -M default";
        v = "bind -M visual";
      in
      ''
        fish_vi_key_bindings

        # default
        ${d} d delete-char
        ${d} x cancel

        # visual
        ${v} x down-line
      ''
      + import ./colors.nix;

    shellInitLast =
      # fish
      ''
        set fish_cursor_default      block
        set fish_cursor_insert       line
        set fish_cursor_replace_one  underscore
        set fish_cursor_replace      underscore
        set fish_cursor_visual       block
        set fish_cursor_external     line
      '';
  };
}
