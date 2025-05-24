{
  config,
  ...
}:

let
  extra = {
    gtk-application-prefer-dark-theme = 1;
    gtk-xft-antialias = 1;
    gtk-xft-hinting = 1;
    gtk-xft-hintstyle = "hintslight";
    gtk-xft-rgba = "rgb";
    gtk-button-images = 0;
    gtk-menu-images = 0;
    gtk-enable-event-sounds = 1;
    gtk-enable-input-feedback-sounds = 0;
  };
in

{
  hm = {
    gtk = {
      gtk3.extraConfig = extra;
      gtk4.extraConfig = extra;
    };

    dconf.settings."org/gnome/desktop/interface" = {
      color-scheme =
        if config.stylix.polarity == "dark" then
          "prefer-dark"
        else if config.stylix.polarity == "light" then
          "prefer-light"
        else
          null;
    };
  };
}
