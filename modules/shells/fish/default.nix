{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (machine == "pcRyazenka" || machine == "thinkpadT14") {
  persist.user.files = [ ".local/share/fish/fish_history" ];

  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [ grc ];

  hm.programs = {
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
            if (machine == "pcRyazenka") then
              "Hyprland"
            else if (machine == "thinkpadT14") then
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
}
