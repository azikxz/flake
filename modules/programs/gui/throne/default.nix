{
  lib,
  ...
}:

with lib;
# INFO:
# new gen nekoray
# ...
# doesnt works...(((

{
  imports = [ ./module.nix ];
}
// (mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  persist.user.dirs = [ ".config/Throne" ];

  programs.throne = {
    enable = true;
    tunMode.enable = true;
  };
})
