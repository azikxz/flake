{
  impermanence = {
    dirs = [
      "/media"
    ];
    # users.${lib.x.sys.userName} = {
    #   directories =
    #     let
    #       mode = "0777";
    #       mk = dir: {
    #         directory = "${dir}";
    #         inherit mode;
    #       };
    #       cache = ".cache/";
    #       local = ".local/";
    #       lState = local + "state/";
    #       lShare = local + "share/";
    #     in
    #     [
    #       # xdg dirs
    #       "Desktop"
    #       "Documents"
    #       "Downloads"
    #       "Music"
    #       "Pictures"
    #       "Videos"
    #       # syncthing
    #       (lState + "syncthing")
    #       (lShare + "syncthing")
    #       (lShare + "qutebrowser")
    #       # telegram
    #       (lShare + "64Gram")
    #       (cache + "stylix-telegram-theme")
    #       # komikku
    #       (lShare + "komikku")
    #       # cli tools
    #       (lShare + "zoxide")
    #       # steam
    #       (lShare + "Steam")
    #       (lShare + "umu")
    #       ".steam"
    #       ".srb2"
    #       ".wine-pfx"
    #       (mk ".ssh")
    #     ];
    #   files = [
    #     ".local/share/fish/fish_history"
    #   ];
    # };
  };
}
