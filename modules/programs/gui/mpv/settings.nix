{
  pkgs,
  lib,
  ...
}:

let
  mkShader = "no-osd change-list glsl-shaders";

  inherit (lib.system)
    itIs
    ;
in

{
  script = {
    sponsorblock-minimal = {
      sponsorblock_minimal-server = "https://sponsor.ajay.app/api/skipSegments";

      sponsorblock_minimal-categories = [
        "selfpromo"
        "sponsor"
      ];
    };

    mpv_thumbnail_script = {
      autogenerate = "yes";
      autogenerate_max_duration = "3600";
      background_color = "000000";
      mpv_no_sub = "no";
      prefer_mpv = "yes";
      thumbnail_count = 150;
      thumbnail_height = 200;
      thumbnail_network = "no";
      thumbnail_width = 200;
    };
  };
  config = {
    fs = "yes";
    osc = "no";

    glsl-shaders = toString (
      with pkgs;
      if (itIs == "laptop") then
        "${anime4k}/Anime4K_Clamp_Highlights.glsl:${anime4k}/Anime4K_Restore_CNN_Soft_M.glsl:${anime4k}/Anime4K_Upscale_CNN_x2_M.glsl:${anime4k}/Anime4K_AutoDownscalePre_x2.glsl:${anime4k}/Anime4K_AutoDownscalePre_x4.glsl:${anime4k}/Anime4K_Upscale_CNN_x2_S.glsl"
      else if (itIs == "desktop") then
        "${anime4k}/Anime4K_Clamp_Highlights.glsl:${anime4k}/Anime4K_Restore_CNN_VL.glsl:${anime4k}/Anime4K_Upscale_CNN_x2_VL.glsl:${anime4k}/Anime4K_Restore_CNN_M.glsl:${anime4k}/Anime4K_AutoDownscalePre_x2.glsl:${anime4k}/Anime4K_AutoDownscalePre_x4.glsl:${anime4k}/Anime4K_Upscale_CNN_x2_M.glsl"
      else
        null
    );
  };

  extra = ''
    ${toString (
      if (itIs == "laptop") then
        (import ./anime4k/laptop.nix {
          inherit mkShader pkgs;
        })

      else if (itIs == "desktop") then
        (import ./anime4k/desktop.nix {
          inherit mkShader pkgs;
        })
      else
        null
    )}

    # fsr
    CTRL+7 ${mkShader} set "${pkgs.mpv-shim-default-shaders}/share/mpv-shim-default-shaders/shaders/FSR.glsl"; show-text "FSR enabled"

    CTRL+0 ${mkShader} clr ""; show-text "GLSL shaders cleared"
  '';
}
