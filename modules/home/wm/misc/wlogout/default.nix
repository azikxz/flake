{
  x,
  lib,
  config,
  ...
}:
with lib;
with x;
let
  cfg = config.module.wm.misc.wlogout;
in
{
  options = {
    module.wm.misc.wlogout = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    programs.wlogout = on // {
      layout = [
        {
          label = "shutdown";
          action = "systemctl poweroff";
          text = "Shutdown";
          keybind = "s";
        }
        {
          label = "reboot";
          action = "systemctl reboot";
          text = "Reboot";
          keybind = "r";
        }
        {
          label = "suspend";
          action = "systemctl suspend";
          text = "Suspend";
          keybind = "u";
        }
        {
          label = "hibernate";
          action = "systemctl hibernate";
          text = "Hibernate";
          keybind = "h";
        }
        {
          label = "lock";
          action = "loginctl lock-session";
          text = "Lock";
          keybind = "l";
        }
        {
          label = "logout";
          action = "loginctl terminate-user $USER";
          text = "Logout";
          keybind = "e";
        }
      ];
      style =
        let
          inherit (config) programs lib;
          p = "share/wlogout/icons";
          icon = n: ''
            #${n} { background-image: image(url("${programs.wlogout.package}/${p}/${n}.png")); }
          '';
        in
        with lib.stylix.colors.withHashtag;
        # css
        ''
          * {	background-image: none; box-shadow: none; }
          window { background-color: ${base00}; }
          button {
            border-radius: 10;
            border-color: ${base0E};
          	text-decoration-color: ${base04};
            color: ${base05};
          	background-color: ${base00};
          	border-style: solid;
          	background-repeat: no-repeat;
          	background-position: center;
          	background-size: 25%;
          }
          button:focus,
          button:active,
          button:hover { background-color: ${base01}; outline-style: none; }
          ${concatMapStringsSep "\n" icon [
            "lock"
            "logout"
            "suspend"
            "hibernate"
            "shutdown"
            "reboot"
          ]}
        '';
    };
  };
}
