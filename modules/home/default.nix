{ x, ... }:
{
  imports = x.umport {
    path = ./.;
    include = [
      ./programs/custom/anicli/default.nix
      ./programs/custom/keydex/default.nix
      ./programs/gui/walogram/default.nix
    ];
    exclude = [
      ./default.nix
      ./programs/gui/floorp/addons.nix
      ./programs/custom
      ./programs/gui/walogram
    ];
  };
}
