{
  lib,
  ...
}:

with lib;
# INFO:
# osd for various actions

mkIf true {
  hm = {
    services.wob = {
      enable = true;

      settings = {
        # INFO: "" it mean to all styles
        "" = {
          timeout = 700;

          orientation = "horizontal";
          anchor = "bottom center";

          width = 48;
          height = 200;

          border_offset = 6;
          border_size = 3;
          margin = 30;
        };
      };
    };

    home.sessionVariables = {
      WOBSOCK = "/run/user/1000/wob.sock";
    };
  };
}
