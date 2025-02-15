{
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.programs.gui.nixcord;
in

{
  options = {
    module.programs.gui.nixcord = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    programs.nixcord = on // {
      discord = off;
      vesktop = on;
      config = {
        useQuickCss = true;
        frameless = true;
        plugins = {
          alwaysAnimate = on;
          alwaysExpandRoles = on;
          betterGifPicker = on;
          betterNotesBox = on;
          betterRoleDot = on;
          betterUploadButton = on;
          copyEmojiMarkdown = on;
          dearrow = on;
          decor = on;
          fakeNitro = on;
          openInApp = on;
          translate = on;
          youtubeAdblock = on;
          hideAttachments = on;
        };
      };
    };
  };
}
