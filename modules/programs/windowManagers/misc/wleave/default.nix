{
  lib,
  config,
  ...
}:

with lib;

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  hm.programs.wleave = {
    enable = true;

    settings = {
      margin = 200;
      buttons-per-row = toString 3;
      column-spacing = 8;

      show-keybinds = false;
      no-version-info = true;

      buttons =
        let
          mk =
            name: action: keybind:
            {
              inherit
                action
                keybind
                ;

              icon = iconMake name;
            }
            // genAttrs [ "label" "text" ] (n: name);

          iconMake =
            name:
            concatStringsSep "/" [
              (toString config.hm.programs.wleave.package)
              "share"
              "wleave"
              "icons"
              "${name}.svg"
            ];
        in
        [
          (mk "shutdown" "systemctl poweroff" "s")
          (mk "reboot" "systemctl reboot" "r")
          (mk "suspend" "systemctl suspend" "u")
          (mk "hibernate" "systemctl hibernate" "h")
          (mk "logout" "loginctl terminate-user $USER" "e")
          (mk "lock" "loginctl lock-session" "l")
        ];
    };

    style =
      with config.lib.stylix.colors.withHashtag;
      ''
        * {
          font-family: "${config.stylix.fonts.monospace.name}";
          font-size: ${toString config.stylix.fonts.sizes.desktop}pt;
          background-image: none;
        }

        window { background-color: ${base00}; }

        button {
          background-color: ${base01};
          color: ${base05};
          border-radius:30px;
        }

        button:focus, button:hover {
          background-color: ${base02};
        }

        button:active {
          color: ${base05};
          background-color: ${base02};
        }
      ''
      + (builtins.concatStringsSep "\n" (
        map
          (
            n:
            (name: color: ''
              button#${name} { --view-fg-color: ${color}; }
            '')
              n.name
              n.color
          )
          [
            {
              name = "shutdown";
              color = base08;
            }
            {
              name = "hibernate";
              color = base0A;
            }
            {
              name = "reboot";
              color = base0B;
            }
            {
              name = "lock";
              color = base0D;
            }
            {
              name = "logout";
              color = base0C;
            }
            {
              name = "suspend";
              color = base0E;
            }
          ]
      ));
  };
}
