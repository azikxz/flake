{
  lib,
  ...
}:

with lib;

mkIf false {
  virtualisation.virtualbox = {
    host = {
      enable = true;
      enableExtensionPack = true;
      enableKvm = true;
      addNetworkInterface = false;
    };

    guest = {
      enable = true;
    };
  };

  users.extraGroups = {
    vboxusers.members = [ system.userName ];
  };
}
