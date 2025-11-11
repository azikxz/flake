{
  lib,
  config,
  ...
}:

with lib;
# INFO:
# best actions for system management

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  hm.programs.wleave = {
    enable = true;

    settings = {
      margin = 200;
      buttons-per-row = toString 2;

      column-spacing = 32;
      row-spacing = 32;

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
          (mk "logout" "loginctl terminate-user $USER" "e")
          (mk "suspend" "systemctl suspend" "u")
          (mk "lock" "hyprlock" "l")
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
          color: oklab(from var(--view-fg-color) var(--standalone-color-oklab));
          border-radius: 30px;
        }

        button:focus, button:hover {
          background-color: ${base02};
        }

        button:active {
          color: var(--accent-fg-color);
          background-color: var(--accent-bg-color);
        }
      ''
      + (builtins.concatStringsSep "\n" (
        map
          (n: ''
            button#${n.name} { --view-fg-color: ${n.color}; }
          '')
          [
            {
              name = "shutdown";
              color = base08;
            }

            {
              name = "logout";
              color = base0A;
            }

            {
              name = "suspend";
              color = base0C;
            }

            {
              name = "lock";
              color = base0E;
            }
          ]
      ));
  };
}
