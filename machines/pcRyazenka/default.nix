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
    "syncthing/password"
  ] ./sopsnix.yaml;

  hm.services.syncthing.settings.devices = listToAttrs [
    (sync.mkDevice "nothing2a" "U2SSOJT-I43YCNB-HAU4LBI-6UWBLRR-AUTELXZ-PZSCFYJ-J3LKH5H-ROFZBQS")
    (sync.mkDevice "blackmamba" "3PWM3G4-KOBIRI7-ZSS63JJ-EWQX5VX-BC5F772-76CZATP-XBP6QOX-HFCGPQN")
    (sync.mkDevice "windauser" "5NRFLQO-KFR4H7P-XGWMLNH-PSYDTNL-CF2D6JZ-PNEK76R-6DSYGSS-ZTFWQQF")
  ];
}
