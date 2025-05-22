{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (itIs == "desktop" || itIs == "laptop") {
  persist.user.files = [ ".local/share/fish/fish_history" ];

  programs.fish.enable = true;

  hm = {
    home.packages = with pkgs; [ grc ];

    programs = {
      fish = {
        enable = true;

        preferAbbrs = true;

        plugins = import ./plugins.nix {
          inherit
            pkgs
            ;
        };

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
          let
            winman =
              if (itIs == "desktop") then
                "Hyprland"
              else if (itIs == "laptop") then
                "Hyprland"
              else
                "fastfetch";
          in
          # fish
          ''
            set fish_cursor_default      block
            set fish_cursor_insert       line
            set fish_cursor_replace_one  underscore
            set fish_cursor_replace      underscore
            set fish_cursor_visual       block
            set fish_cursor_external     line

            [ "$(tty)" = "/dev/tty1" ] && exec ${winman}
          '';
      };
    };
  };
}
