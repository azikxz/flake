{
  pkgs,
  lib,
  config,
  ...
}:

with config.lib.stylix.colors.withHashtag;

{
  screenshot-path = "~/Pictures/screenshots/scr_%d-%m-%y_%H:%M:%S.png";

  outputs = {
    "eDP-1".scale = 1.0;
  };

  input = {
    keyboard.xkb = {
      layout = "us,ru";
      options = "grp:caps_toggle, lv3:ralt_switch";
    };

    mouse = {
      scroll-method = "no-scroll";
      accel-profile = "adaptive";
    };

    trackpoint = {
      scroll-method = "on-button-down";
      accel-profile = "flat";
    };

    touchpad = {
      tap = true;
      dwt = true;
      dwtp = true;

      natural-scroll = false;

      click-method = "clickfinger";
      scroll-method = "two-finger";
      accel-profile = "adaptive";
    };

    power-key-handling.enable = false;
    focus-follows-mouse.enable = false;
    workspace-auto-back-and-forth = false;
  };

  cursor = {
    hide-when-typing = true;
    hide-after-inactive-ms = 1000;
  };

  layout = {
    background-color = base00;

    border =
      let
        mk = from: to: {
          gradient = {
            relative-to = "workspace-view";
            angle = 45;

            inherit
              from
              to
              ;
          };
        };
      in
      {
        enable = true;
        width = 5;

        active.color = base01;
        inactive.color = base01;
        urgent = mk base08 base09;
      };

    insert-hint = {
      display.color = base01 + "CC";
    };

    gaps = 8;

    struts = lib.genAttrs [
      "left"
      "right"
      "top"
      "bottom"
    ] (n: 4);

    shadow = {
      enable = true;
      softness = 30;
      draw-behind-window = true;

      color = base00 + "70";
      inactive-color = base00 + "70";
    };

    default-column-width.proportion = 0.9;

    preset-column-widths = [
      { proportion = 0.4; }
      { proportion = 0.5; }
      { proportion = 0.9; }
      { proportion = 1.0; }
    ];

    preset-window-heights = [
      { proportion = 0.4; }
      { proportion = 0.5; }
      { proportion = 1.0; }
    ];

    center-focused-column = "on-overflow";
    always-center-single-column = true;
  };

  animations =
    (lib.genAttrs
      [
        "horizontal-view-movement"
        "window-movement"
        "window-resize"
      ]
      (n: {
        kind.spring = {
          damping-ratio = 0.760000;
          epsilon = 0.000100;
          stiffness = 700;
        };
      })
    )
    // (lib.genAttrs
      [
        "window-close"
        "window-open"
        "workspace-switch"
      ]
      (n: {
        kind.easing = {
          duration-ms = 150;
          curve = "ease-out-expo";
        };
      })
    )
    // { };

  window-rules = [
    {
      clip-to-geometry = true;
      geometry-corner-radius = lib.genAttrs [
        "top-left"
        "top-right"
        "bottom-left"
        "bottom-right"
      ] (n: 12.0);
    }
  ]
  ++ import ./rules.nix {
    inherit
      lib
      ;
  };

  workspaces = lib.genAttrs (map toString (lib.range 1 5)) (n: { });

  overview = {
    zoom = 0.95;
    backdrop-color = base00;

    workspace-shadow = {
      softness = 20;
      spread = 14;

      color = base00;
    };
  };

  clipboard.disable-primary = true;
  gestures.hot-corners.enable = false;
  hotkey-overlay.skip-at-startup = true;
  prefer-no-csd = true;

  environment = {
    DISPLAY = ":0";
    SLURP_ARGS = "-b ${base00}CC -c ${base0F}FF -B ${base02}CC";
    WOBSOCK = config.hm.home.sessionVariables.WOBSOCK;
  };

  xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;
}
