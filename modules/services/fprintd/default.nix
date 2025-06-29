{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (machine == "thinkpadT14") {
  services.fprintd = {
    enable = true;

    package = pkgs._24.fprintd-tod;

    tod = {
      enable = true;

      driver = pkgs._24.libfprint-2-tod1-vfs0090;
    };
  };
}
