{
  lib,
  config,
  ...
}:

with lib;
let
  inherit (config.hm.services.mpd)
    dataDir
    ;

  socket = "${dataDir}/mpd_socket";
  fifo = "${dataDir}/fifo_socket";
in
# INFO: idk lazy to fix...zzZ

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  hm = {
    programs.rmpc = {
      enable = true;
      config = import ./settings.nix {
        inherit
          socket
          fifo
          ;
      };
    };

    services.mpd = {
      enable = true;
      extraConfig = # conf
        ''
          audio_output {
            type "pipewire"
            name "PipeWire Output"
          }

          audio_output {
             type   "fifo"
             name   "Fifo Output"
             path   "${fifo}"
             format "44100:16:2"
          }

          bind_to_address "${socket}"
        '';
    };
  };
}
