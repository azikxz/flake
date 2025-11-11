{
  pkgs,
  lib,
  ...
}:

with lib;
# INFO:
# rusted replacement for much software

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  environment = {
    shellAliases = {
      cp = getExe' pkgs.fuc "cpz";
    };

    systemPackages = with pkgs; [
      hunt
      ripgrep-all
      sd
    ];
  };

  hm = {
    home.shellAliases = {
      cat = "bat";
    };

    programs = {
      ripgrep.enable = true;

      fd = {
        enable = true;

        ignores = [
          ".git/"
          "*.bak"
        ];
      };

      fzf = {
        enable = true;

        defaultOptions = [
          "--border=rounded"
          "--info=hidden"
          "--no-mouse"
          "--margin=5%"
          "--padding=3%"
        ];
      };

      eza = {
        enable = true;

        icons = "auto";

        extraOptions = [
          "--group-directories-first"
          "--icons=always"
        ];
      };

      bat = {
        enable = true;

        extraPackages = attrValues {
          inherit (pkgs.bat-extras)
            prettybat
            batwatch
            batgrep
            batdiff
            ;
        };

        config.wrap = "character";
      };
    };
  };
}
