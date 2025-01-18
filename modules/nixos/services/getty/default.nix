{
  x,
  lib,
  config,
  ...
}:
with lib;
with x;
let
  cfg = config.module.services.getty;
in
{
  options = {
    module.services.getty = {
      enable = mkBool;
    };
  };

  config = mkIf cfg.enable {
    services.getty = {
      greetingLine = "Good day my lord ahhhh ${userName}";
      helpLine = "";
      autologinOnce = true;
    };
  };
}
