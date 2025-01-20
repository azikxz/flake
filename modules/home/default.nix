{ x, ... }:
{
  imports = x.umport {
    path = ./.;
    include = [
      ./programs/gui/walogram/default.nix
      ./wm/hyprland/default.nix
    ];
    exclude = [
      ./default.nix
      ./programs/gui/walogram
      ./programs/gui/floorp/addons.nix
      ./wm/hyprland
    ];
  };
}
