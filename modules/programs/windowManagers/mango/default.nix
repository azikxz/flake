{
  lib,
  config,
  ...
}:

with lib;
# INFO:
# take screenshots and edit them

mkIf true {
  hm.wayland.windowManager.mango = {
    enable = true;

    settings = import ./settings.nix {
      inherit
        lib
        config
        ;
    };
  };
}
