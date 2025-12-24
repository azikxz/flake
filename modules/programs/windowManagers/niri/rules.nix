{
  lib,
  ...
}:

[
  {
    open-maximized = false;
    matches = [
      { is-floating = false; }
      { is-floating = true; }
    ];
  }

  {
    opacity = 0.9;
    matches = [
      { is-focused = false; }
    ];
  }

  {
    open-on-workspace = "2";
    matches = [
      { app-id = "org.qutebrowser.qutebrowser"; }
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
    default-column-width = 0.4;
    matches = [
      {
        app-id = "steam$";
        title = "^Friends List$";
      }
    ];
  }

  {
    open-focused = false;
    matches = [
      {
        app-id = "steam";
        title = ''^notificationtoasts_\d+_desktop$'';
      }
    ];
    geometry-corner-radius = lib.genAttrs [
      "top-left"
      "top-right"
      "bottom-left"
      "bottom-right"
    ] (n: 4.0);
    clip-to-geometry = true;
    default-floating-position = {
      x = -10;
      y = -10;
      relative-to = "bottom-right";
    };
  }
]
