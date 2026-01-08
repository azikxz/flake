{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
# INFO:
# > gdu /path/to/path

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  hmPackages = [ pkgs.gdu ];

  hm.xdg.configFile = {
    # idk why in man path is ~/.gdu.yaml
    "gdu/gdu.yaml".text =
      with config.lib.stylix.colors.withHashtag;
      # yaml
      ''
        log-file: "/dev/null"
        max-cores: 4
        follow-symlinks: false

        show-apparent-size: false
        show-relative-size: false
        show-item-count: true
        show-mtime: true
        sequential-scanning: false

        no-mouse: true
        non-interactive: false
        no-progress: false
        no-unicode: false
        no-cross: false
        no-hidden: false
        no-delete: false

        use-si-prefix: true

        progress-modal.current-item-path-max-len: 0
        style.use-old-size-bar: true
        delete-in-background: true
        delete-in-parallel: true
        sorting:
          order: "desc"

        ignore-dirs:
          - /proc
          - /dev
          - /sys
          - /run
      ''
      + (optionalString config.hm.stylix.targets.gdu.enable ''
        style:
          selected-row:
            text-color: "${base0B}"
            background-color: "${base02}"
          result-row:
            directory-color: "${base0B}"
            number-color: "${base0F}"
          footer:
            text-color: "${base05}"
            background-color: "${base01}"
            number-color: "${base08}"
          header:
            text-color: "${base05}"
            background-color: "${base01}"
            hidden: true
      '');
  };
}
