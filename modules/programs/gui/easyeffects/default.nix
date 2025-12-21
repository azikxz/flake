{
  inputs,
  pkgs,
  lib,
  ...
}:

with lib;
# INFO:
# just cool

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  persist.user.dirs = [ ".config/easyeffects" ];

  hm = {
    disabledModules = [ "services/easyeffects.nix" ];
    imports = [ ./module.nix ];

    services.easyeffects = {
      enable = true;
      package = pkgs._2505.easyeffects;

      preset =
        if (mac "thinkpadT14") then
          "thinkpadT14"
        else if (mac "pcRyazenka") then
          "perfectEQ"
        else
          "perfectEQ";

      extraPresets = mapAttrs (n: v: v) inputs.easyeffects.effects;
    };
  };
}
