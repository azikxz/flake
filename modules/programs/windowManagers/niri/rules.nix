{
  lib,
  config,
  ...
}:

# INFO:
# "^name$" - exact match
# "^name"  - start with name
# "name&"  - ends with name
# "name"   - name everywhere
let
  corner =
    rounding:
    lib.genAttrs [
      "top-left"
      "top-right"
      "bottom-left"
      "bottom-right"
    ] (n: rounding);

  border = color: {
    active = { inherit color; };
    inactive = { inherit color; };
    urgent = { inherit color; };
  };

  size = height: width: {
    default-column-width.fixed = width;
    default-window-height.fixed = height;
  };
in

with config.lib.stylix.colors.withHashtag;

[
  {
    open-maximized = false;
    open-fullscreen = false;
  }
]
++ (
  let
    mk = ws: app-id: {
      open-on-workspace = toString ws;
      matches = [
        {
          inherit
            app-id
            ;
        }
      ];
    };
  in
  [
    # workspaces rules
    (mk 2 "org.qutebrowser.qutebrowser")
    (mk 2 "spotify")
    (mk 3 "com.ayugram.desktop")
    (mk 3 "equibop")
    (mk 3 "mumble")
    (mk 5 "steam")
  ]
)
++ [
  # windows rules
  {
    default-column-width.proportion = 0.5;
    matches = [
      {
        app-id = "kitty_small";
      }
    ];
  }

  {
    default-column-width.proportion = 0.5;
    block-out-from = "screen-capture";
    matches = [
      { title = "^.*1Password.*$"; }
      { title = "^.*Bitwarden.*$"; }
      { title = "^.*KeePassXC.*$"; }
    ];
  }

  (
    {
      open-floating = true;
      open-focused = true;
      block-out-from = "screen-capture";
      matches = [
        {
          app-id = "org.keepassxc.KeePassXC$";
          title = "^Generate Password$";
        }
      ];
    }
    // (size 1041 501)
  )

  {
    open-floating = true;
    geometry-corner-radius = corner 4.0;
    border = border base08;
    matches = [
      {
        app-id = "dragon-drop";
      }
    ];
  }

  {
    open-floating = true;
    matches = [
      {
        app-id = "firefox$";
        title = "^Picture-in-Picture$";
      }
    ];
  }

  {
    block-out-from = "screencast";
    matches = [
      {
        app-id = "ayugram";
      }
    ];
  }

  {
    open-fullscreen = true;
    matches = [
      {
        app-id = "ayugram";
        title = "Media viewer";
      }
    ];
  }

  (
    {
      matches = [
        {
          app-id = "wofi";
          title = "Bluetooth";
        }
      ];
    }
    // (size 960 470)
  )

  {
    default-column-width.proportion = 0.4;
    matches = [
      {
        app-id = "steam$";
        title = "^Friends List$";
      }
    ];
  }

  {
    open-focused = false;
    clip-to-geometry = true;
    geometry-corner-radius = corner 4.0;
    default-floating-position = {
      x = -10;
      y = -10;
      relative-to = "bottom-right";
    };
    matches = [
      {
        app-id = "steam";
        title = ''^notificationtoasts_\d+_desktop$'';
      }
    ];
  }
]
