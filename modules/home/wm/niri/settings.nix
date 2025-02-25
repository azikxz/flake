{
  lib,
  config,
  ...
}:

let
  inherit (lib.x) on off;
  makeCommand = command: {
    command = [ command ];
  };
in
with config.lib.stylix.colors.withHashtag;

{
  spawn-at-startup = [ (makeCommand "mako") ];
  screenshot-path = "~/Pictures/scr/scr_%d-%m-%y_%H:%M:%S.png";
  input = {
    # jmakalka
    keyboard.xkb = {
      layout = "us,ru";
      options = "grp:caps_toggle";
    };
    # rat
    mouse = {
      scroll-method = "no-scroll";
      accel-profile = "flat";
    };
    # glass?
    trackpoint = {
      scroll-method = "on-button-down";
      accel-profile = "flat";
    };
    # clitor
    touchpad = {
      tap = true;
      dwt = true;
      dwtp = true;
      natural-scroll = true;
      disabled-on-external-mouse = true;
      click-method = "clickfinger";
      scroll-method = "two-finger";
      accel-profile = "adaptive";
    };
    warp-mouse-to-focus = true;
    focus-follows-mouse.enable = true;
    workspace-auto-back-and-forth = false;
  };
  outputs = {
    # laptop
    "eDP-1" = {
      scale = 1.2;
    };
    # monitor
    "HDMI-A-1" = {
      scale = 1.0;
    };
  };
  cursor = {
    size = config.stylix.cursor.size;
    theme = "${config.stylix.cursor.name}";
    hide-when-typing = true;
    hide-after-inactive-ms = 1000;
  };
  layout = {
    # style
    focus-ring = off;
    border = on // {
      width = 3;
      active = {
        color = base0E;
        # gradient = {
        #   angle = 130;
        #   relative-to = "workspace-view";
        #   from = "#${theme.base0D}";
        #   to = "#${theme.base0E}";
        # };
      };
      inactive.color = base01;
    };
    # preset
    default-column-width.proportion = 1.0 / 2.0;
    preset-column-widths = [
      { proportion = 1.0 / 3.0; }
      { proportion = 1.0 / 2.0; }
      { proportion = 2.0 / 3.0; }
      { proportion = 1.0 / 1.0; }
    ];
    # apperance
    gaps = 8;
    struts = {
      left = 0;
      right = 0;
      top = 0;
      bottom = 0;
    };
    # hedgehog
    # shadow = on // {
    #   softness = 30;
    #   draw-behind-window = true;
    #   color = "${base00}70";
    #   inactive-color = "${base00}70";
    # };
    # tabs
    # tab-indicator = on // {
    #   hide-when-single-tab = true;
    #   gap = 5;
    #   width = 4;
    #   position = "right";
    #   gaps-between-tabs = 2;
    #   corner-radius = 12;
    #   active-color = "${base09}";
    #   inactive-color = "${base01}";
    # };
  };
  animations =
    let
      spring = {
        damping-ratio = 0.760000;
        epsilon = 0.000100;
        stiffness = 700;
      };
      easing = {
        duration-ms = 150;
        curve = "ease-out-expo";
      };
    in
    {
      horizontal-view-movement.spring = spring;
      workspace-switch.spring = spring;
      window-movement.spring = spring;
      window-resize.spring = spring;
      window-open.easing = easing;
      window-close.easing = easing;
      # idk
      shaders.window-resize = ''
        vec4 resize_color(vec3 coords_curr_geo, vec3 size_curr_geo) {
          vec3 coords_next_geo = niri_curr_geo_to_next_geo * coords_curr_geo;

          vec3 coords_stretch = niri_geo_to_tex_next * coords_curr_geo;
          vec3 coords_crop = niri_geo_to_tex_next * coords_next_geo;

          // We can crop if the current window size is smaller than the next window
          // size. One way to tell is by comparing to 1.0 the X and Y scaling
          // coefficients in the current-to-next transformation matrix.
          bool can_crop_by_x = niri_curr_geo_to_next_geo[0][0] <= 1.0;
          bool can_crop_by_y = niri_curr_geo_to_next_geo[1][1] <= 1.0;

          vec3 coords = coords_stretch;
          if (can_crop_by_x)
              coords.x = coords_crop.x;
          if (can_crop_by_y)
              coords.y = coords_crop.y;

          vec4 color = texture2D(niri_tex_next, coords.st);

          // However, when we crop, we also want to crop out anything outside the
          // current geometry. This is because the area of the shader is unspecified
          // and usually bigger than the current geometry, so if we don't fill pixels
          // outside with transparency, the texture will leak out.
          //
          // When stretching, this is not an issue because the area outside will
          // correspond to client-side decoration shadows, which are already supposed
          // to be outside.
          if (can_crop_by_x && (coords_curr_geo.x < 0.0 || 1.0 < coords_curr_geo.x))
              color = vec4(0.0);
          if (can_crop_by_y && (coords_curr_geo.y < 0.0 || 1.0 < coords_curr_geo.y))
              color = vec4(0.0);

          return color;
        }
      '';
    };
  prefer-no-csd = true;
  hotkey-overlay.skip-at-startup = true;
}
