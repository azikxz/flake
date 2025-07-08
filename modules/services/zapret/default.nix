{
  lib,
  ...
}:

with lib;

mkIf (machine == "pcRyazenka") {
  services.zapret = {
    enable = true;

    sf_presets = {
      enable = true;
      preset = "general";
    };
  };
}
