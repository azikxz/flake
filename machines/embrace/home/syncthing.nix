{
  services.syncthing.settings = {
    devices =
      let
        mk = id: {
          id = "${id}";
          autoAcceptFolders = true;
        };
      in
      {
        redmi = mk "U4DLNUR-EWQYZ6L-MPWKN73-GFBPPRU-RIUHT4A-Z62XM66-ZBNPQBI-SV3EBQZ";
        jetpure = mk "LDQ26D4-4MWXSFX-DCXYOGS-6MEXTQG-OYRTWA5-XE32FWS-WLAMKJ6-VVIONQ2";
      };
    folders =
      let
        mk = id: { id = "${id}"; };
      in
      {
        "/persist/vault" = mk "passwords";
      };
  };
}
