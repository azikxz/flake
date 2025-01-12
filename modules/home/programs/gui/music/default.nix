{
  x,
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
with lib;
with x;
let
  inherit (pkgs) system;
  inherit (spicePkgs) extensions snippets;
  cfg = config.module.programs.gui.music;
  font = config.stylix.fonts;
  spicePkgs = inputs.spicetify.legacyPackages.${system};
in
{
  options = {
    module.programs.gui.music = {
      spotify.enable = mkBool;
      amberol.enable = mkBool;
    };
  };

  imports = with inputs; [ spicetify.homeManagerModules.default ];
  config = mkMerge [
    (mkIf cfg.amberol.enable { services.amberol = True; })
    (mkIf cfg.spotify.enable {
      programs.spicetify = True // {
        theme = spicePkgs.themes.sleek // {
          additionalCss = # css
            ''*{font-family:"${font.monospace.name}"!important}'';
        };
        colorScheme = "custom";
        customColorScheme = with config.lib.stylix.colors; {
          # BASE 16 SCHEME
          accent = "${base03}";
          accent-active = "${base03}";
          accent-inactive = "${base02}";
          banner = "${base03}";
          border-active = "${base03}";
          border-inactive = "${base03}";
          header = "${base00}";
          highlight = "${base04}";
          text = "${base06}";

          subtext = "${base06}";
          sidebar-text = "${base07}";
          main = "${base00}";
          sidebar = "${base01}";
          player = "${base00}";
          card = "${base00}";
          shadow = "${base00}";
          selected-row = "${base03}";
          button = "${base0B}";
          button-active = "${base0B}";
          button-disabled = "${base03}";
          tab-active = "${base04}";
          notification = "${base0A}";
          notification-error = "${base08}";
          misc = "${base02}";
        };
        enabledExtensions = with extensions; [
          # IMPORTANT
          fullAppDisplay
          betterGenres
          keyboardShortcut

          #COMMUNITY
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
          hideFriendsActivityButton
          hideFullScreenButton
          hideDownloadButton
          hideMiniPlayerButton
          leftAlignedHeartIcons
          hideSidebarScrollbar
          betterLyricsStyle
          queueTopSidePanel
        ];
      };
    })
  ];
}
