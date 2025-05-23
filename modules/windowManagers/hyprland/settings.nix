{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with config.lib.stylix.colors;

{
  env = [ "SLURP_ARGS, -b ${base00}CC -c ${base0F}FF -B ${base02}CC" ];

  exec-once =
    let
      mic = pkgs.writeShellScriptBin "micMute" ''
        fixf4=$(cat /sys/class/leds/platform\:\:micmute/brightness);
        echo $((1-fixf4)) | sudo tee /sys/class/leds/platform\:\:micmute/brightness;
        wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
      '';
    in
    [
      (getExe mic)
      "mako"
      "steam"
      "waybar"
    ];

  monitor =
    if itIs == "laptop" then
      "eDP-1, 1920x1080@60, 0x0, 1, transform, 0"
    else
      "HDMI-A-1, 1920x1080@60, 0x0, 1, transform, 0";

  general = {
    gaps_in = 4;
    gaps_out = 10;
    border_size = 3;

    layout = "dwindle";

    "col.active_border" = mkForce "rgb(${base01})";
    "col.inactive_border" = mkForce "rgb(${base01})";
  };

  decoration = {
    rounding = 12;

    dim_inactive = true;
    dim_strength = 0.3;

    shadow = {
      enabled = true;

      range = 10;
      render_power = 8;
    };

    blur = {
      enabled = true;

      size = 4;
      passes = 4;
      noise = 0.03;
      vibrancy = 0.9;

      new_optimizations = true;
      ignore_opacity = true;
      popups = false;
      special = true;
      xray = false;
    };
  };

  group = {
    "col.border_active" = mkForce "rgb(${base0C}) rgb(${base0B}) 45deg";
    "col.border_inactive" = mkForce "rgb(${base01})";

    groupbar = {
      gradients = false;
      render_titles = false;

      "col.active" = mkForce "rgb(${base05})";
      "col.inactive" = mkForce "rgb(${base01})";
    };
  };

  # animations
  animations = {
    enabled = true;

    first_launch_animation = false;

    bezier = [
      "over,     0,    0.1, 0.1, 0.3"
      "myBezier, 0.05, 0.9, 0.1, 1.0"
    ];

    animation = [
      "windowsIn,   1, 3, myBezier, popin 80%"
      "windowsOut,  1, 3, myBezier, popin 80%"
      "windowsMove, 1, 2, over"

      "border,              1, 3,   myBezier"
      "workspaces,          1, 2.7, default, slide"
      "specialWorkspaceIn,  1, 1,   default, fade"
      "specialWorkspaceOut, 1, 1,   default, fade"

      "fade,       1, 2, myBezier"
      "fadeShadow, 1, 4, default"
    ];
  };

  # clitor | touchpad | rat
  cursor.inactive_timeout = 1;

  input = {
    kb_layout = "us,ru";
    kb_options = "grp:caps_toggle";

    touchpad = {
      natural_scroll = false;
      disable_while_typing = false;
    };
  };

  device = [
    {
      name = "synps/2-synaptics-touchpad";
      accel_profile = "adaptive";
    }
    {
      name = "tpps/2-elan-trackpoint";
      accel_profile = "custom 200 1 -0.1";
      scroll_points = "0.2 0.0 0.5 1 1.2 1.5";
    }
  ];

  gestures = {
    workspace_swipe = true;
    workspace_swipe_fingers = 3;
    workspace_swipe_create_new = true;
  };

  binds = {
    workspace_back_and_forth = false;
    allow_pin_fullscreen = true;
  };

  # dwinsle layout
  dwindle = {
    pseudotile = true;
    preserve_split = true;
    smart_resizing = true;
    force_split = 2;
  };

  ecosystem.no_update_news = true;
  misc = {
    disable_hyprland_logo = true;
    disable_splash_rendering = true;
    mouse_move_enables_dpms = true;

    vfr = true;
    vrr = 1;

    animate_manual_resizes = true;
    animate_mouse_windowdragging = true;

    enable_swallow = true;
    close_special_on_empty = true;

    background_color = mkForce "rgb(${base00})";
  };
}
