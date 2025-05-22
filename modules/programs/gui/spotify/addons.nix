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
  theme = themes.sleek // {
    additionalCss = import ./themeCss.nix {
      inherit config;
    };
  };

  enabledExtensions = builtins.attrValues {
    inherit (extensions)
      adblock
      beautifulLyrics
      betterGenres
      fullAppDisplayMod
      keyboardShortcut
      seekSong
      ;
  };

  enabledSnippets = builtins.attrValues {
    inherit (snippets)
      betterLyricsStyle
      centeredLyrics
      fixDjIcon
      fixLikedButton
      fixLikedIcon
      fixListenTogetherButton
      fixListeningOn
      fixMainViewWidth
      fixNowPlayingIcon
      fixPlaylistAndFolderPosition
      fixPlaylistHover
      fixProgressBar
      fixedEpisodesIcon
      hideDownloadButton
      hideFriendActivityButton
      hideFullScreenButton
      hideMiniPlayerButton
      hideNowPlayingViewButton
      hidePlayCount
      hidePlayingGif
      hideProfileUsername
      hideSidebarScrollbar
      leftAlignedHeartIcons
      moreVisibleUnplayableTracks
      pointer
      prettyLyrics
      queueTopSidePanel
      removeConnectBar
      removeGradient
      removeTheArtistsAndCreditsSectionsFromTheSidebar
      removeTopSpacing
      roundedImages
      roundedNowPlaying
      ;
  };
}
