{
  lib,
  ...
}:

with lib;
# INFO: new gen nekoray

{
  imports = [ ./module.nix ];
}
// (mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  programs.throne = {
    enable = true;
    tunMode.enable = true;
  };
})
