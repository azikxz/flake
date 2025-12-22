[
  {
    matches = [ { is-focused = false; } ];
    opacity = 0.9;
  }

  {
    open-on-workspace = "2";
    matches = [
      {
        app-id = "org.qutebrowser.qutebrowser";
      }
    ];
  }

  {
    matches = [
      {
        app-id = "firefox$";
        title = "^Picture-in-Picture$";
      }
    ];
    open-floating = true;
  }
]
