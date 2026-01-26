{
  lib,
  ...
}:

{
  sync = {
    mkFilter = config: list: lib.attrNames (removeAttrs config list);

    mkDevice = name: id: {
      inherit
        name
        ;

      value = {
        inherit
          id
          ;

        autoAcceptFolders = true;
        compression = "always";
      };
    };

    mkFolder =
      {
        id,
        name,
        path,
        devices,
      }:
      {
        inherit
          name
          ;

        value = {
          inherit
            id
            path
            devices
            ;

          rescanIntervalS = 4;
          versioning = {
            type = "simple";
            params = {
              cleanupIntervalS = toString (60 * 2);
              cleanoutDays = toString (7 * 4);
              keep = toString (7 * 1);
            };
          };
        };
      };
  };
}
