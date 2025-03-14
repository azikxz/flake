{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  inherit (inputs) spicetify;
  inherit (pkgs)
    system
    ;
  inherit (spicePkgs)
    extensions
    snippets
    apps
    ;
  cfg = config.module.programs.gui.spotify;
  spicePkgs = spicetify.legacyPackages.${system};
in

{
  options = {
    module.programs.gui.spotify = {
      enable = mkBool false;
    };
  };

  imports = [ spicetify.homeManagerModules.default ];
  config = mkIf cfg.enable {
    programs.spicetify = on // {
      theme = spicePkgs.themes.sleek // {
        additionalCss = # css
          ''*{font-family:"${config.stylix.fonts.monospace.name}"!important}'';
      };
      colorScheme = "custom";
      customColorScheme = with config.lib.stylix.colors; {
        accent = base03;
        accent-active = base03;
        accent-inactive = base02;
        banner = base03;
        border-active = base03;
        border-inactive = base03;
        header = base00;
        highlight = base04;
        text = base06;
        subtext = base06;
        sidebar-text = base07;
        main = base00;
        sidebar = base01;
        player = base00;
        card = base00;
        shadow = base00;
        selected-row = base03;
        button = base0B;
        button-active = base0B;
        button-disabled = base03;
        tab-active = base04;
        notification = base0A;
        notification-error = base08;
        misc = base02;
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
      enabledCustomApps = with apps; [
        lyricsPlus
        newReleases
        betterLibrary
        historyInSidebar
      ];
    };
  };
}
