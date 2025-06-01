{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (itIs == "laptop") {
  services.fprintd = {
    enable = true;

    package = pkgs._24.fprintd-tod;

    tod = {
      enable = true;

      driver = pkgs._24.libfprint-2-tod1-vfs0090;
    };
  };
}
