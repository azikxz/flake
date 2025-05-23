{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (itIs == "laptop") {
  services.fprintd = {
    enable = true;

    package = pkgs.stable.fprintd-tod;

    tod = {
      enable = true;

      driver = pkgs.stable.libfprint-2-tod1-vfs0090;
    };
  };
}
