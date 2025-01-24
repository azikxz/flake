{
  config,
  ...
}:
with config.lib.stylix.colors;
{
  lscolors_enabled = true;
  tabs.styles = {
    active = {
      bg = "${base00}";
      fg = "${base0E}";
      bold = true;
    };
    inactive = {
      bg = "${base00}";
      fg = "${base03}";
      bold = false;
    };
  };
}
