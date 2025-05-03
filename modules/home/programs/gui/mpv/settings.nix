{
  pkgs,
  lib,
  ...
}:

let
  mkShader = "no-osd change-list glsl-shaders";
  inherit (lib.x.sys) is;
in

{
  script = {
    sponsorblock-minimal = {
      sponsorblock_minimal-server = "https://sponsor.ajay.app/api/skipSegments";
      sponsorblock_minimal-categories = [
        "sponsor"
        "selfpromo"
      ];
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
      background_color = "000000";
    };
  };
  config = {
    fs = "yes";
    osc = "no";
    glsl-shaders = toString (
      with pkgs;
      if (is == "laptop") then
        "${anime4k}/Anime4K_Clamp_Highlights.glsl:${anime4k}/Anime4K_Restore_CNN_Soft_M.glsl:${anime4k}/Anime4K_Upscale_CNN_x2_M.glsl:${anime4k}/Anime4K_AutoDownscalePre_x2.glsl:${anime4k}/Anime4K_AutoDownscalePre_x4.glsl:${anime4k}/Anime4K_Upscale_CNN_x2_S.glsl"
      else if (is == "desktop") then
        "${anime4k}/Anime4K_Clamp_Highlights.glsl:${anime4k}/Anime4K_Restore_CNN_VL.glsl:${anime4k}/Anime4K_Upscale_CNN_x2_VL.glsl:${anime4k}/Anime4K_Restore_CNN_M.glsl:${anime4k}/Anime4K_AutoDownscalePre_x2.glsl:${anime4k}/Anime4K_AutoDownscalePre_x4.glsl:${anime4k}/Anime4K_Upscale_CNN_x2_M.glsl"
      else
        null
    );
  };
  extra = ''
    ${toString (
      if (is == "laptop") then
        (import ./anime4k/laptop.nix {
          inherit
            mkShader
            pkgs
            ;
        })
      else if (is == "desktop") then
        (import ./anime4k/desktop.nix {
          inherit
            mkShader
            pkgs
            ;
        })
      else
        null
    )}
    # fsr
    CTRL+7 ${mkShader} set "${pkgs.mpv-shim-default-shaders}/share/mpv-shim-default-shaders/shaders/FSR.glsl"; show-text "FSR enabled"
    CTRL+0 ${mkShader} clr ""; show-text "GLSL shaders cleared"
  '';
}
