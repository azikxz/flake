{
  lib,
  ...
}:

let
  inherit (lib.x) on off;
in

{
  # cli
  tmux = on;
  cava = on // {
    rainbow = on;
  };
  fish = on;
  nushell = on;
  starship = on;
  # wm
  hyprland = on // {
    hyprpaper = on;
  };
  hyprpaper = on;
  niri = on;
  sway = on;
  river = on;
  # misc
  foot = on;
  kitty = on;
  mako = off;
  rofi = on;
  bemenu = on;
  # tools
  nixvim = on;
  yazi = on;
  fzf = on;
  bat = on;
  mangohud = on;
  # gui
  spicetify = off;
  nixcord = on;
  zathura = on;
  qutebrowser = on;
  firefox = on;
  floorp = on;
  halloy = on;
  gtk = on;
}
