{
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
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    services.getty = {
      greetingLine = "Good day my lord ahhhh ${sys.userName}";
      helpLine = "";
      autologinOnce = true;
    };
  };
}
