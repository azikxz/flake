{
  inputs,
  lib,
  ...
}:

with lib;

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  persist.user.dirs = [ ".config/easyeffects" ];

  hm = {
    services.easyeffects = {
      enable = true;

      preset =
        if (mac "thinkpadT14") then
          "thinkpadT14-output"
        else if (mac "pcRyazenka") then
          "perfectEQ"
        else
          "perfectEQ";

      extraPresets = mapAttrs (n: v: v) inputs.easyeffects.effects;
    };
  };
}
