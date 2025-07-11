{
  lib,
  ...
}:

with lib;

mkIf (mac "pcRyazenka") {
  services.zapret = {
    enable = true;

    sf_presets = {
      enable = true;
      preset = "general";
    };
  };
}
