{
  x,
  config,
  ...
}:

with config.lib.stylix.colors;
let
  mk = {
    text = x.gen "toINI" {
      ColorScheme = {
        active_colors = "#ff${base05}, #ff${base01}, #ff${base01}, #ff${base05}, #ff${base03}, #ff${base04}, #ff${base05}, #ff${base06}, #ff${base05}, #ff${base01}, #ff${base00}, #ff${base03}, #ff${base02}, #ff${base05}, #ff${base09}, #ff${base08}, #ff${base02}, #ff${base05}, #ff${base01}, #ff${base0E}, #8f${base0E}";
        inactive_colors = "#ff${base04}, #ff${base01}, #ff${base01}, #ff${base05}, #ff${base03}, #ff${base04}, #ff${base04}, #ff${base04}, #ff${base04}, #ff${base01}, #ff${base00}, #ff${base03}, #ff${base02}, #ff${base05}, #ff${base09}, #ff${base08}, #ff${base02}, #ff${base05}, #ff${base01}, #ff${base0E}, #8f${base0E}";
        disabled_colors = "#ff${base02}, #ff${base01}, #ff${base01}, #ff${base05}, #ff${base03}, #ff${base04}, #ff${base02}, #ff${base0F}, #ff${base0F}, #ff${base01}, #ff${base00}, #ff${base03}, #ff${base02}, #ff${base05}, #ff${base09}, #ff${base08}, #ff${base02}, #ff${base05}, #ff${base01}, #ff${base0F}, #8f${base0F}";
      };
    };
  };
in
{
  "qt5ct/colors/stylix.conf" = mk;
  "qt6ct/colors/stylix.conf" = mk;
}
