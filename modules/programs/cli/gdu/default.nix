{
  pkgs,
  lib,
  config,
  ...
}:

with lib;

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  environment.systemPackages = [ pkgs.gdu ];

  hm.home.file.".gdu.yaml".text =
    with config.lib.stylix.colors.withHashtag;
    (generators.toYAML { } {
      style = {
        log-file = "/dev/null";

        max-cores = 4;
        follow-symlinks = false;

        show-apparent-size = true;
        show-relative-size = false;
        show-item-count = true;
        show-mtime = true;
        sequential-scanning = false;

        no-mouse = true;
        non-interactive = false;
        no-progress = false;
        no-unicode = false;
        no-cross = false;
        no-hidden = false;
        no-delete = true;

        use-si-prefix = true;

        selected-row = {
          text-color = base0B;
          background-color = base02;
        };

        footer = {
          text-color = base05;
          background-color = base01;
          number-color = base08;
        };

        result-row = {
          directory-color = base0B;
          number-color = base0F;
        };

        header = {
          text-color = base05;
          background-color = base01;
          hidden = true;
        };

        progress-modal.current-item-path-max-len = 0;
        style.use-old-size-bar = true;
      };
    });
}
