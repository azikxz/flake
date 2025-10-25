{
  lib,
  ...
}:

with lib;

{
  imports = umport {
    path = ./.;

    exclude = [
      ./default.nix
    ];
  };

  sops.secrets = mkSecrets.sops [
    "syncthing/cert"
    "syncthing/key"
  ] ./sopsnix.yaml;

  hm.services.syncthing.settings.devices = listToAttrs [
    (sync.mkDevice "nothing2a" "U2SSOJT-I43YCNB-HAU4LBI-6UWBLRR-AUTELXZ-PZSCFYJ-J3LKH5H-ROFZBQS")
    (sync.mkDevice "jetpure" "DW4SRMG-3CK3ZRU-4Q2WQC3-O5FUM77-6BKCEDD-BFMDFOL-PCWOHAX-DUTMHQS")
  ];
}
