{
  pkgs,
  config,
  ...
}:

with config.lib.stylix.colors;
let
  ini = pkgs.formats.ini { };

  color = ini.generate "stylix.conf" {
    ColorScheme = {
      active_colors = builtins.concatStringsSep ", " [
        "#ff${base05}"
        "#ff${base01}"
        "#ff${base01}"
        "#ff${base05}"
        "#ff${base03}"
        "#ff${base04}"
        "#ff${base05}"
        "#ff${base06}"
        "#ff${base05}"
        "#ff${base01}"
        "#ff${base00}"
        "#ff${base03}"
        "#ff${base02}"
        "#ff${base05}"
        "#ff${base09}"
        "#ff${base08}"
        "#ff${base02}"
        "#ff${base05}"
        "#ff${base01}"
        "#ff${base0E}"
        "#8f${base0E}"
      ];
      disabled_colors = builtins.concatStringsSep ", " [
        "#ff${base04}"
        "#ff${base01}"
        "#ff${base01}"
        "#ff${base05}"
        "#ff${base03}"
        "#ff${base04}"
        "#ff${base04}"
        "#ff${base04}"
        "#ff${base04}"
        "#ff${base01}"
        "#ff${base00}"
        "#ff${base03}"
        "#ff${base02}"
        "#ff${base05}"
        "#ff${base09}"
        "#ff${base08}"
        "#ff${base02}"
        "#ff${base05}"
        "#ff${base01}"
        "#ff${base0E}"
        "#8f${base0E}"
      ];
      inactive_colors = builtins.concatStringsSep ", " [
        "#ff${base04}"
        "#ff${base01}"
        "#ff${base01}"
        "#ff${base05}"
        "#ff${base03}"
        "#ff${base04}"
        "#ff${base04}"
        "#ff${base04}"
        "#ff${base04}"
        "#ff${base01}"
        "#ff${base00}"
        "#ff${base03}"
        "#ff${base02}"
        "#ff${base05}"
        "#ff${base09}"
        "#ff${base08}"
        "#ff${base02}"
        "#ff${base05}"
        "#ff${base01}"
        "#ff${base0E}"
        "#8f${base0E}"
      ];
    };
  };
in

color
