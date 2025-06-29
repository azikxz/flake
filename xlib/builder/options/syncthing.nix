{
  sync = {
    mkDevice = name: id: {
      inherit
        name
        ;
      value = {
        inherit
          id
          ;
        autoAcceptFolders = true;
      };
    };

    mkFolder = name: path: devices: {
      inherit
        name
        ;
      value = {
        inherit
          path
          devices
          ;

        rescanIntervalS = 10;
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
