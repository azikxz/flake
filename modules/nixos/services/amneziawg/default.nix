{
  x,
  pkgs,
  lib,
  config,
  ...
}:
with lib;
with x;
let
  cfg = config.module.services.amneziawg;
in
{
  options = {
    module.services.amneziawg = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    environment = {
      etc = {
        "amnezia/amneziawg/awg.conf".text = ''
          [Interface]
          PrivateKey = aK7bWvyhNqBPHvzps5nFZzhEYl/MeQdyKU0eQXLB1XA=
          S1 = 0
          S2 = 0
          Jc = 120
          Jmin = 23
          Jmax = 911
          H1 = 1
          H2 = 2
          H3 = 3
          H4 = 4
          MTU = 1280
          Address = 172.16.0.2, 2606:4700:110:8021:e5ba:e628:c4c5:9979
          DNS = 1.1.1.1, 2606:4700:4700::1111, 1.0.0.1, 2606:4700:4700::1001

          [Peer]
          PublicKey = bmXOC+F1FxEMF9dyiK2H5/1SUtzH0JuVo51h2wPfgyo=
          AllowedIPs = 0.0.0.0/0, ::/0
          Endpoint = 188.114.97.66:3138
        ''; # WARP
        "amnezia/amneziawg/topor.conf".text = ''
          [Interface]
          PrivateKey = +AGMFCg3dEMm1iZCoeV6MbDeLs7+fPYlBFNIvwE9nHA=
          S1 = 0
          S2 = 0
          Jc = 4
          Jmin = 40
          Jmax = 70
          H1 = 1
          H2 = 2
          H3 = 3
          H4 = 4
          MTU = 1280
          Address = 172.16.0.2, 2606:4700:110:8984:5fe5:9b44:72c9:890d
          DNS = 1.1.1.1, 2606:4700:4700::1111, 1.0.0.1, 2606:4700:4700::1001

          [Peer]
          PublicKey = bmXOC+F1FxEMF9dyiK2H5/1SUtzH0JuVo51h2wPfgyo=
          AllowedIPs = 0.0.0.0/0, ::/0
          Endpoint = engage.cloudflareclient.com:2408
        ''; # TOPOR
        "amnezia/amneziawg/anon_ru.conf".text = ''
          [Interface]
          Address = 10.66.66.11/32, fd42:42:42::11/128
          DNS = 1.1.1.1, 1.0.0.1
          ListenPort = 1080
          MTU = 1280
          Jc = 4
          Jmin = 40
          Jmax = 70
          H1 = 1
          H2 = 2
          H3 = 3
          H4 = 4
          PrivateKey = iO83F3lfz/tvwySySNdvEA47XYi6TlUEiyleEnVoxWI=

          [Peer]
          AllowedIPs = 0.0.0.0/0, ::/0
          Endpoint = www.anonymous.com.ru1.vpnlabs.xyz:51820
          PreSharedKey = CyS+c4kv5N4ohIMkL/fNsB/6bOcmPpGAhd2O7WkXqOU=
          PublicKey = BW+9cfhTzy31DaUkr6ON1Ud73wweSUDENbfiBp/Evmc=
        ''; # ANON RU
        "amnezia/amneziawg/anon_us.conf".text = ''
          [Interface]
          Address = 10.66.66.3/32, fd42:42:42::3/128
          DNS = 1.1.1.1, 1.0.0.1
          ListenPort = 1080
          MTU = 1280
          Jc = 4
          Jmin = 40
          Jmax = 70
          H1 = 1
          H2 = 2
          H3 = 3
          H4 = 4
          PrivateKey = UGgL8x4j1PhvjPdM7T9b6+EvqVRytIp9rNkR6y3T6nU=

          [Peer]
          AllowedIPs = 0.0.0.0/0, ::/0
          Endpoint = www.anonymous.com.us1.vpnlabs.xyz:51820
          PreSharedKey = pq1sQFrtobOj+Crk7EgeXLRwX0I8uPoRaYuBnNZnegs=
          PublicKey = qTlMhwDZcoATJ8wek8+aqIaJVkBnRcqRohb/ctPII30=
        ''; # ANON US
      };
      systemPackages = with pkgs; [
        amneziawg-tools
        amneziawg-go
      ];
    };
    boot.extraModulePackages = with pkgs.linuxKernel.packages.linux_zen; [ amneziawg ];
  };
}
