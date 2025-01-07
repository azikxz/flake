{ x, ... }:
{
  imports = x.umport {
    path = ./.;
    include = [
      ./programs/custom/anicli/default.nix
    ];
    exclude = [
      ./default.nix
      ./programs/gui/floorp/addons.nix
      ./programs/custom
    ];
  };
}
