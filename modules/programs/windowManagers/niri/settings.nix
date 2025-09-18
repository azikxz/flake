{
  pkgs,
  lib,
  config,
  ...
}:

with config.lib.stylix.colors.withHashtag;

{
  screenshot-path = "~/Pictures/screenshots/scr_%d-%m-%y_%H:%M:%S.png";

  spawn-at-startup =
    map
      (reference: {
        command = [ reference ];
      })
      [
        (lib.getExe pkgs.xwayland-satellite)
        "${lib.getExe pkgs.swaybg} --image ${config.stylix.image}"
      ];

  input = {
    keyboard.xkb = {
      layout = "us,ru";
      options = "grp:caps_toggle";
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

    focus-follows-mouse.enable = true;
    workspace-auto-back-and-forth = false;
  };

  cursor = {
    hide-when-typing = true;
    hide-after-inactive-ms = 1000;
  };

  layout = {
    focus-ring.enable = false;

    border = {
      enable = true;
      width = 3;

      active.color = base01;
      inactive.color = base01;
      urgent.color = base08;
    };

    insert-hint = {
      display.color = base01;
    };

    center-focused-column = "on-overflow";
    always-center-single-column = true;

    default-column-width.proportion = 0.85;

    gaps = 4;

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

    {
      matches = [ { is-focused = false; } ];
      opacity = 0.9;
    }
  ]
  ++ import ./rules/main.nix;

  overview = {
    zoom = 0.8;
    backdrop-color = base01;

    workspace-shadow = {
      softness = 20;
      spread = 14;

      color = base00;
    };
  };

  gestures.hot-corners.enable = false;

  prefer-no-csd = true;
  hotkey-overlay.skip-at-startup = true;

  outputs = {
    "eDP-1".scale = 1.0;
  };

  workspaces = lib.genAttrs (map toString (lib.range 1 9)) (n: { });

  environment = {
    DISPLAY = ":0";
  };
}
