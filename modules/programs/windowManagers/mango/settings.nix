{
  lib,
  config,
  ...
}:

# INFO:
# https://github.com/DreamMaoMao/mango/wiki/

let
  col = (
    with lib;
    mapAttrs
      (
        name: value:
        if (match "base.*" name != null && isString value) then
          "0x${replaceStrings [ "#" ] [ "" ] value}ff"
        else
          value
      )
      {
        inherit (config.lib.stylix.colors)
          base00
          base01
          base02
          base03
          base04
          base05
          base06
          base07
          base08
          base09
          base0A
          base0B
          base0C
          base0D
          base0E
          base0F
          ;
      }
  );
in
with col;

# idk why, but hypr syntacs is good for it
# hypr
''
  blur = 1
  blur_layer = 0
  blur_optimized = 1
  blur_params_num_passes = 2
  blur_params_radius = 5
  blur_params_noise = 0.02
  blur_params_brightness = 0.9
  blur_params_contrast = 0.9
  blur_params_saturation = 1.2

  shadows = 1
  layer_shadows = 0
  shadow_only_floating = 1
  shadows_size = 10
  shadows_blur = 15
  shadows_position_x = 0
  shadows_position_y = 0
  shadowscolor= ${base00}

  border_radius = 12
  no_border_when_single = 1
  no_radius_when_single = 1
  focused_opacity = 1.0
  unfocused_opacity = 0.8

  animations = 1
  layer_animations = 1
  animation_type_open = slide
  animation_type_close = slide
  animation_fade_in = 1
  animation_fade_out = 1
  tag_animation_direction = 1
  zoom_initial_ratio = 0.3
  zoom_end_ratio = 0.8
  fadein_begin_opacity = 0.5
  fadeout_begin_opacity = 0.8
  animation_duration_move = 500
  animation_duration_open = 400
  animation_duration_tag = 350
  animation_duration_close = 800
  animation_curve_open = 0.46,1.0,0.29,1
  animation_curve_move = 0.46,1.0,0.29,1
  animation_curve_tag = 0.46,1.0,0.29,1
  animation_curve_close = 0.08,0.92,0,1

  scroller_structs = 16
  scroller_default_proportion = 0.9
  scroller_focus_center = 1
  scroller_prefer_center = 1
  scroller_proportion_preset = 0.5,0.8,1.0

  new_is_master = 0
  default_mfact = 0.55
  default_nmaster = 1
  smartgaps = 1

  hotarea_size = 10
  enable_hotarea = 1
  ov_tab_mode = 0
  overviewgappi = 5
  overviewgappo = 30

  axis_bind_apply_timeout = 100
  focus_on_activate = 1
  inhibit_regardless_of_visibility = 0
  sloppyfocus = 1
  warpcursor = 1
  focus_cross_monitor = 0
  focus_cross_tag = 0
  enable_floating_snap = 0
  snap_distance = 30
  cursor_size = 24
  drag_tile_to_tile = 1

  repeat_rate = 25
  repeat_delay = 600
  numlockon = 1
  xkb_rules_layout = us,ru
  xkb_rules_options = grp:caps_toggle

  disable_trackpad = 0
  disable_while_typing = 1
  drag_lock = 1
  left_handed = 0
  middle_button_emulation = 0
  mouse_natural_scrolling = 0
  swipe_min_threshold = 1
  tap_and_drag = 1
  tap_to_click = 1
  trackpad_natural_scrolling = 0

  gappih = 8
  gappiv = 8
  gappoh = 8
  gappov = 8

  scratchpad_width_ratio = 0.8
  scratchpad_height_ratio = 0.9

  borderpx = 3
  rootcolor = ${base09}
  bordercolor = ${base01}
  focuscolor = ${base0C}
  maxmizescreencolor = ${base01}
  urgentcolor = ${base08}
  scratchpadcolor = ${base05}
  globalcolor = ${base02}
  overlaycolor = ${base03}

  # tile,scroller,grid,deck,monocle,center_tile,vertical_tile,vertical_scroller
  tagrule = id:1,layout_name:vertical_scroller
  tagrule = id:2,layout_name:vertical_scroller
  tagrule = id:3,layout_name:vertical_scroller
  tagrule = id:4,layout_name:vertical_scroller
  tagrule = id:5,layout_name:vertical_scroller
  tagrule = id:6,layout_name:vertical_scroller
  tagrule = id:7,layout_name:vertical_scroller
  tagrule = id:8,layout_name:vertical_scroller
  tagrule = id:9,layout_name:vertical_scroller

  bind=SUPER,Return,spawn,kitty

  bind=SUPER+SHIFT,E,quit
  bind=SUPER,C,killclient

  bind=SUPER,Tab,focusstack,next
  bind=SUPER,H,focusdir,left
  bind=SUPER,L,focusdir,right
  bind=SUPER,K,focusdir,up
  bind=SUPER,J,focusdir,down

  bind=SUPER+SHIFT,K,exchange_client,up
  bind=SUPER+SHIFT,J,exchange_client,down
  bind=SUPER+SHIFT,H,exchange_client,left
  bind=SUPER+SHIFT,L,exchange_client,right

  bind=SUPER,G,toggleglobal
  bind=ALT,Tab,toggleoverview
  bind=ALT,Backslash,togglefloating
  bind=ALT,A,togglemaxmizescreen
  bind=ALT,F,togglefullscreen
  bind=ALT+SHIFT,F,togglefakefullscreen
  bind=SUPER,I,minimized
  bind=SUPER,O,toggleoverlay
  bind=SUPER+SHIFT,I,restore_minimized
  bind=ALT,Z,toggle_scratchpad

  bind=ALT,E,set_proportion,1.0
  bind=ALT,X,switch_proportion_preset

  bind=SUPER,n,switch_layout

  bind=SUPER,1,view,1,0
  bind=SUPER,2,view,2,0
  bind=SUPER,3,view,3,0
  bind=SUPER,4,view,4,0
  bind=SUPER,5,view,5,0
  bind=SUPER,6,view,6,0
  bind=SUPER,7,view,7,0
  bind=SUPER,8,view,8,0
  bind=SUPER,9,view,9,0

  bind=SUPER+SHIFT,1,tag,1,0
  bind=SUPER+SHIFT,2,tag,2,0
  bind=SUPER+SHIFT,3,tag,3,0
  bind=SUPER+SHIFT,4,tag,4,0
  bind=SUPER+SHIFT,5,tag,5,0
  bind=SUPER+SHIFT,6,tag,6,0
  bind=SUPER+SHIFT,7,tag,7,0
  bind=SUPER+SHIFT,8,tag,8,0
  bind=SUPER+SHIFT,9,tag,9,0

  bind=SUPER+CTRL,1,toggletag,1,0
  bind=SUPER+CTRL,2,toggletag,2,0
  bind=SUPER+CTRL,3,toggletag,3,0
  bind=SUPER+CTRL,4,toggletag,4,0
  bind=SUPER+CTRL,5,toggletag,5,0
  bind=SUPER+CTRL,6,toggletag,6,0
  bind=SUPER+CTRL,7,toggletag,7,0
  bind=SUPER+CTRL,8,toggletag,8,0
  bind=SUPER+CTRL,9,toggletag,9,0

  bind=SUPER+SHIFT+CTRL,1,toggleview,1,0
  bind=SUPER+SHIFT+CTRL,2,toggleview,2,0
  bind=SUPER+SHIFT+CTRL,3,toggleview,3,0
  bind=SUPER+SHIFT+CTRL,4,toggleview,4,0
  bind=SUPER+SHIFT+CTRL,5,toggleview,5,0
  bind=SUPER+SHIFT+CTRL,6,toggleview,6,0
  bind=SUPER+SHIFT+CTRL,7,toggleview,7,0
  bind=SUPER+SHIFT+CTRL,8,toggleview,8,0
  bind=SUPER+SHIFT+CTRL,9,toggleview,9,0
''
