{
  lib,
  ...
}:

with lib.sync;

{
  hm.services.syncthing.settings.devices = builtins.listToAttrs [
    (mkDevice "nothing2a" "U2SSOJT-I43YCNB-HAU4LBI-6UWBLRR-AUTELXZ-PZSCFYJ-J3LKH5H-ROFZBQS")
    (mkDevice "blackmamba" "3PWM3G4-KOBIRI7-ZSS63JJ-EWQX5VX-BC5F772-76CZATP-XBP6QOX-HFCGPQN")
  ];
}
