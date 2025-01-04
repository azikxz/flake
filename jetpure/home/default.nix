{ x, config, ... }:
let
  inherit (x) True False umport;
in
{
  imports = umport {
    exclude = [ ./default.nix ];
    path = ./.;
  };
  module = {
    programs = {
      cli = {
        bat = True;
        cava = True;
        eza = True;
        fetch = True;
        fzf = True;
        git = True;
        gpg = True;
        helix = True;
        joshuto = False;
        legendary = True;
        lsd = False;
        micro = False;
        rustmission = True;
        top = True;
        yazi = True;
        zoxide = True;
      };
      gui = {
        floorp = False;
        minecraft = True // {
          cli = True;
        };
        mpv = True;
        obs = True;
        qbittorrent = True;
        qutebrowser = True;
        spotify = True;
        swayimg = True;
        zed = False;
      };
      custom = {
        anicli = True;
      };
    };
    shells = {
      fish = True;
      nushell = False;
      tmux = False;
      zsh = False;
      starship = True;
    };
    themes = {
      gtk = True; # GTK APPS
      qt = True; # QT APPS
      stylix = True // {
        icon = "adwaita";
        cursor = with config.lib.stylix.colors.withHashtag; {
          bg = "${base0E}";
          ol = "${base00}";
          ac = "${base0E}";
        };
      };
    };
    wm = {
      hyprland = True;
      sway = False;
      terminals = {
        kitty = True;
        foot = False;
        wezterm = False;
      };
      misc = {
        mako = True;
        nwg = False;
        rofi = False;
        tofi = True;
        waybar = False;
        wob = False;
        yofi = False;
      };
    };
    misc = {
      dconf = True;
      xdg.mime = True;
    };
  };
}
