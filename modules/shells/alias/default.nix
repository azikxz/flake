{
  pkgs,
  lib,
  config,
  ...
}:

with lib;

mkIf (itIs == "desktop" || itIs == "laptop") {
  hm = {
    programs.fish.shellAbbrs = {
      s = "sudo";
    };

    home.shellAliases = with pkgs; {
      # nix
      nixPre = "nix store prefetch-file";
      nixUpd = "nix flake update";

      # override default
      trash = getExe trashy + " put";
      touch = getExe bonk;
      find = getExe hunt;
      frep = getExe ripgrep-all;
      # cp = "${getExe' fuc "cpz"}";
      # rm = "${getExe' fuc "rmz"}";

      cat = getExe bat;

      # quality of life
      e = "$EDITOR";
      c = "clear";
      x = "exit";

      # useful
      ca = "cava";
      pmx = "pulsemixer";
      blt = getExe bluetui;
      icat = "kitten icat";

      # tops
      btop = "btop";
      ntop = "nvtop -i";

      # clock
      ter =
        getExe tenki
        + "
          --fps 80 \
          --wind disable \
          --timer-color cyan \
          --mode rain
        ";

      # translate
      tr = "trans --brief";
    };

    xdg.configFile."lutgen/stylix".text =
      with config.lib.stylix.colors;
      "${builtins.concatStringsSep " " [
        base00
        base01
        base02
        base03
        base04
        base05
        base06
        base07
        base08
        base09
        base0A
        base0B
        base0C
        base0D
        base0E
        base0F
      ]}";
  };
}
