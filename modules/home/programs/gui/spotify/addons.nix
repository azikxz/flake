{
  inputs,
  pkgs,
  config,
}:

let
  spicePkgs = inputs.spicetify.legacyPackages.${pkgs.system};
  inherit (spicePkgs)
    extensions
    snippets
    themes
    ;
in

{
  theme = themes.default // {
    additionalCss =
      # css
      ''
        * {
          font-family: "${config.stylix.fonts.monospace.name}" !important
        }
      '';
  };
  enabledExtensions = with extensions; [
    fullAppDisplay
    betterGenres
    keyboardShortcut
    adblockify
    historyShortcut
    beautifulLyrics
    powerBar
    seekSong
    history
  ];
  enabledSnippets = with snippets; [
    fixLikedButton
    smoothPlaylistRevealGradient
    hideFriendActivityButton
    centeredLyrics
    pointer
    removeConnectBar
    fixedEpisodesIcon
    fixProgressBar
    roundedImages
    fixMainViewWidth
    fixPlaylistHover
    hideNowPlayingViewButton
    fixLikedIcon
    removeTopSpacing
    hideFullScreenButton
    hideDownloadButton
    hideMiniPlayerButton
    leftAlignedHeartIcons
    hideSidebarScrollbar
    betterLyricsStyle
    queueTopSidePanel
  ];
}
