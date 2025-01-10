{
  x,
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (pkgs) libnotify;
  dag = lib.hm.dag.entryAfter [ "" ];
  papirus = config.stylix.iconTheme.package;
in
with x;
{
  programs.home-manager = True;
  home = {
    username = userName;
    homeDirectory = "/home/${userName}";
    stateVersion = ver;
    activation = {
      rebuildFinish = dag ''
        run ${libnotify}/bin/notify-send "Home-Manager   rebuild finished" -t 1500 -i "${papirus}/share/icons/Papirus-Dark/64x64/apps/nix-snowflake.svg"
      '';
    };
  };
}
