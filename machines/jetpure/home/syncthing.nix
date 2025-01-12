{
  services.syncthing.settings = {
    devices = {
      redmi = {
        name = "Redmi Note 7";
        id = "U4DLNUR-EWQYZ6L-MPWKN73-GFBPPRU-RIUHT4A-Z62XM66-ZBNPQBI-SV3EBQZ";
        autoAcceptFolders = true;
      };
    };
    folders = {
      "/persist/vault" = {
        id = "passwords";
        type = "sendreceive";
      };
      "~/Music" = {
        id = "music";
        type = "sendreceive";
      };
    };
  };
}
