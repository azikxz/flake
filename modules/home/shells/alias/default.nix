{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.home;
in

{
  options = {
    home = {
      shellAbbrs = mkAttrs.str { };
    };
  };

  config = {
    programs.fish.shellAbbrs = cfg.shellAbbrs;
    home.shellAbbrs = {
      s = "sudo";
    };
    home.shellAliases = with pkgs; {
      goToFlake = "cd ${lib.x.path.flake}";
      rebuild = "nh os switch -H ${lib.x.machineName}";
      nixRepl = "nh os repl -H ${lib.x.machineName}";
      # override default
      trash = "${getExe trashy} put";
      touch = "${getExe bonk}";
      find = "${getExe hunt}";
      frep = "${getExe ripgrep-all}";
      # cp = "${getExe' fuc "cpz"}";
      # rm = "${getExe' fuc "rmz"}";
      cat = "${getExe bat}";
      # quality of life
      e = "$EDITOR";
      c = "clear";
      x = "exit";
      # nix
      Npre = "nix store prefetch-file";
      Nupd = "nix flake update";
      # useful
      ca = "cava";
      pmx = "pulsemixer";
      blt = "${getExe bluetuith}";
      icat = "kitten icat";
      # tops
      btop = "btop";
      ntop = "nvtop -i";
      # clock
      ter = "${getExe tenki} --mode rain --wind disable --timer-color cyan -f 80";
      tes = "${getExe tenki} --mode snow --wind disable --timer-color yellow -f 80";
      tem = "${getExe tenki} --mode meteor --wind disable --timer-color red -f 80";
      # translate
      tr = "trans --brief";
    };
    xdg.configFile."lutgen/stylix".text =
      with config.lib.stylix.colors;
      "${base00} ${base01} ${base02} ${base03} ${base04} ${base05} ${base06} ${base07} ${base08} ${base09} ${base0A} ${base0B} ${base0C} ${base0D} ${base0E} ${base0E}";
  };
}
