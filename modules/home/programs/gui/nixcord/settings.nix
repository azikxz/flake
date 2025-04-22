{
  lib,
  ...
}:

with lib.x;

{
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
}
