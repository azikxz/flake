{
  lib,
  config,
  ...
}:

with lib;

mkIf (itIs == "desktop" || itIs == "laptop") {
  hm.programs.kitty = {
    enable = true;

    keybindings = import ./binds.nix;

    extraConfig = import ./extraConfig.nix;

    settings =
      import ./settings.nix
      // import ./colors.nix {
        inherit
          config
          ;
      };
  };
}
