{
  lib,
  config,
  ...
}:

with lib;

mkIf (machine == "pcRyazenka" || machine == "thinkpadT14") {
  environment.variables = {
    TERM = "kitty";
    TERMINAL = "kitty";
  };

  hm.programs.kitty = {
    enable = true;
    enableGitIntegration = true;

    keybindings = import ./binds.nix {
      inherit
        config
        ;
    };

    # extraConfig = import ./extraConfig.nix;

    settings =
      import ./settings.nix
      // import ./colors.nix {
        inherit
          config
          ;
      };
  };
}
