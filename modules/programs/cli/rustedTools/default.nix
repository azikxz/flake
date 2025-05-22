{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (itIs == "desktop" || itIs == "laptop") {
  hm = {
    home.packages = with pkgs; [ sd ];
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
          "--margin=1,49%,1,1"
          "--padding=0"
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

        extraPackages = with pkgs.bat-extras; [
          prettybat
          batwatch
          batgrep
          batdiff
        ];

        config.wrap = "character";
      };
    };
  };
}
