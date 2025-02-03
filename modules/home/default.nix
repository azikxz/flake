{ x, ... }:
{
  imports = x.umport {
    path = ./.;
    include = [
      ./programs/gui/qutebrowser/default.nix
      ./programs/gui/telegram/default.nix
      ./programs/cli/joshuto/default.nix
      ./wm/terminals/kitty/default.nix
      ./programs/cli/helix/default.nix
      ./programs/cli/yazi/default.nix
      ./programs/gui/mpv/default.nix
      ./shells/translate/default.nix
      ./wm/misc/waybar/default.nix
      ./wm/hyprland/default.nix
      ./shells/fish/default.nix
      ./shells/zsh/default.nix
      ./themes/qt/default.nix
      ./misc/xdg/default.nix
      ./wm/sway/default.nix
    ];
    exclude = [
      ./default.nix
      ./programs/gui/qutebrowser
      ./programs/gui/telegram
      ./programs/cli/joshuto
      ./wm/terminals/kitty
      ./programs/cli/helix
      ./programs/cli/yazi
      ./programs/gui/mpv
      ./shells/translate
      ./wm/misc/waybar
      ./wm/hyprland
      ./shells/fish
      ./shells/zsh
      ./themes/qt
      ./misc/xdg
      ./wm/sway
    ];
  };
}
