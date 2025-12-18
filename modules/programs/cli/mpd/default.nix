{
  lib,
  ...
}:

with lib;
# INFO:
# idk lazy to fix...zzZ

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  hm = {
    services = {
      mpd = {
        enable = true;

        extraConfig = # conf
          ''
            audio_output {
              type "pipewire"
              name "PipeWire Output"
            }
          '';

        network = {
          startWhenNeeded = true;
        };
      };

      mpd-mpris = {
        enable = true;

        mpd.useLocal = true;
      };
    };
  };
}
