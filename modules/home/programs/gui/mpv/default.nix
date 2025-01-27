{
  x,
  pkgs,
  lib,
  config,
  ...
}:
with lib;
with x;
let
  inherit (pkgs) mpvScripts anime4k;
  cfg = config.module.programs.gui.mpv;
in
{
  options = {
    module.programs.gui.mpv = {
      enable = mkBool;
    };
  };

  config = mkIf cfg.enable {
    programs.mpv = on // {
      bindings = import ./bindings.nix;
      scripts = with mpvScripts; [
        sponsorblock-minimal
        thumbnail
      ];
      scriptOpts = {
        sponsorblock-minimal = {
          sponsorblock_minimal-server = "https://sponsor.ajay.app/api/skipSegments";
          sponsorblock_minimal-categories = [ "sponsor" ];
        };
        mpv_thumbnail_script = {
          autogenerate = "yes";
          autogenerate_max_duration = "3600";
          prefer_mpv = "yes";
          mpv_no_sub = "no";
          thumbnail_width = 200;
          thumbnail_height = 200;
          thumbnail_count = 150;
          thumbnail_network = "no";
          background_color = "282828";
        };
      };
      config = {
        fs = "yes";
        osc = "no";
        glsl-shaders =
          let
            mk =
              if x.is == "laptop" then
                "${anime4k}/Anime4K_Clamp_Highlights.glsl:${anime4k}/Anime4K_Restore_CNN_Soft_M.glsl:${anime4k}/Anime4K_Upscale_CNN_x2_M.glsl:${anime4k}/Anime4K_AutoDownscalePre_x2.glsl:${anime4k}/Anime4K_AutoDownscalePre_x4.glsl:${anime4k}/Anime4K_Upscale_CNN_x2_S.glsl"
              else if x.is == "desktop" then
                "${anime4k}/Anime4K_Clamp_Highlights.glsl:${anime4k}/Anime4K_Restore_CNN_VL.glsl:${anime4k}/Anime4K_Upscale_CNN_x2_VL.glsl:${anime4k}/Anime4K_AutoDownscalePre_x2.glsl:${anime4k}/Anime4K_AutoDownscalePre_x4.glsl:${anime4k}/Anime4K_Upscale_CNN_x2_M.glsl"
              else
                null;
          in
          "${toString mk}";
      };
      extraInput =
        let
          mk =
            if x.is == "laptop" then
              (import ./anime4k/laptop.nix { inherit pkgs; })
            else if x.is == "desktop" then
              (import ./anime4k/desktop.nix { inherit pkgs; })
            else
              null;
        in
        ''
          ${toString mk}

          CTRL+0 no-osd change-list glsl-shaders clr ""; show-text "GLSL shaders cleared"
        '';
    };
  };
}
