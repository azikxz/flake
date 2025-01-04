{
  x,
  pkgs,
  lib,
  config,
  ...
}:
with lib;
with x;
let
  cfg = config.module.shells.nushell;
in
{
  options = {
    module.shells.nushell = {
      enable = mkBool;
    };
  };

  config = mkIf cfg.enable {
    programs.nushell =
      with pkgs;
      True
      // {
        configFile.text = ''
          $env.config = {
            show_banner: false
            edit_mode: vi
            footer_mode: always
            filesize: { metric: true }
            ls: { clickable_links: false }
            rm: { always_trash: true }
            table: {
              mode: compact_double
              index_mode: always
              header_on_separator: true
              padding: { left: 2, right: 1 }
            }
            completions: {
              algorithm: fuzzy
              quick: true
              case_sensitive: false
              external: {
                enable: true
                max_results: 50
                completer: { |spans| ${carapace}/bin/carapace $spans.0 nushell ...$spans | from json }
              }
            }
          }

          def llm [] { ls | sort-by modified }
          def lls [ term: string ] { ls | where { |it| ($it.name | str contains $term ) } }
          def pss [ term: string ] { ps | where { |it| ($it.name | str contains $term ) } }
          def wy [ video_id: string ] { mpv $"https://youtube.com/watch?v=($video_id)" }
        '';
        envFile.text = ''
          $env.EDITOR = "${helix}/bin/hx"
          $env.BROWSER = "zen"
          $env.XDG_CONFIG_HOME = $"($env.HOME)/.config"
          $env.DIRENV_LOG_FORMAT = ""
        '';
      };
  };
}
