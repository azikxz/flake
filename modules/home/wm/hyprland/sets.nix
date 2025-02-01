{
  x,
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkForce;
  cfg = config.module.wm.hyprland;
  on = {
    enabled = true;
  };
in
with config.lib.stylix.colors;
{
  env = [ "SLURP_ARGS, -b ${base00}CC -c ${base0F}FF -B ${base02}CC" ];
  exec-once =
    let
      tee = "${pkgs.uutils-coreutils-noprefix}/bin/tee";
    in
    [
      "wpctl set-volume @DEFAULT_AUDIO_SINK@ 1"
      ''bash -c fixf4=$(cat /sys/class/leds/platform\:\:micmute/brightness); echo $((1-fixf4)) | sudo ${tee} /sys/class/leds/platform\:\:micmute/brightness; wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle''
    ]
    ++ cfg.autostart;
  monitor =
    if x.is == "desktop" then
      "eDP-1, 1920x1080@60, 0x0, 1.2, transform, 0"
    else if x.is == "laptop" then
      "eDP-1, 1920x1080@60, 0x0, 1, transform, 0"
    else
      "eDP-1, 1920x1080@60, 0x0, 1, transform, 0";
  # apperance
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
    shadow = on // {
      range = 10;
      render_power = 8;
    };
    blur = on // {
      size = 4;
      passes = 4;
      noise = 0.03;
      new_optimizations = true;
      ignore_opacity = true;
      vibrancy = 0.9;
      popups = false;
      special = true;
      xray = true;
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
  animations = on // {
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
      disable_while_typing = true;
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
    # vfr = true;
    vrr = 1;
    animate_manual_resizes = true;
    animate_mouse_windowdragging = true;
    # enable_swallow = true;
    close_special_on_empty = true;
    background_color = mkForce "rgb(${base00})";
  };
}
