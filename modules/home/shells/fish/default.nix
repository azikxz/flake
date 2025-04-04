{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.shells.fish;
in

{
  options = {
    module.shells.fish = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ grc ];
    programs = {
      fish = on // {
        package = pkgs.fish;
        preferAbbrs = true;
        plugins = import ./plugins.nix {
          inherit
            pkgs
            ;
        };
        interactiveShellInit =
          (import ./colors.nix)
          + (
            let
              d = "bind -M default";
              v = "bind -M visual";
            in
            # fish
            ''
              fish_vi_key_bindings

              # default
              ${d} d delete-char
              ${d} x cancel

              # visual
              ${v} x down-line
            ''
          );
        shellInitLast =
          let
            winman =
              if (x.sys.is == "desktop") then
                "Hyprland"
              else if (x.sys.is == "laptop") then
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

            [ "$(tty)" = "/dev/tty1" ] && exec ${winman} # LAUNCH WM
          '';
      };
    };
  };
}
