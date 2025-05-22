{
  pkgs,
  lib,
}:

with lib;
let
  inherit (pkgs.nur.repos.rycee.firefox-addons)
    buildFirefoxXpiAddon
    ;
in

{
  "torrserver-adder" = buildFirefoxXpiAddon {
    pname = "torrserver-adder";

    version = "2.0.5";
    addonId = "84z74tXJKt8OUrTD@TSA";

    url = "https://addons.mozilla.org/firefox/downloads/file/4264581/torrserver_adder-2.0.5.xpi";
    sha256 = "6783c13fe423c14fbf9dd23ea3232167dc78eeb298594ab802aa9a7b094fb365";

    meta = {
      homepage = "https://github.com/Noperkot/TorrServerAdder";
      description = "Allows you to add torrents to TorrServer and play them using the system media player";
      license = licenses.mpl20;
      mozPermissions = [
        "http://*/*"
        "https://*/*"
        "contextMenus"
        "downloads"
        "storage"
        "tabs"
        "webRequest"
        "webRequestBlocking"
      ];
    };
  };

  "proton-pass" = buildFirefoxXpiAddon {
    pname = "proton-pass";

    version = "1.24.1";
    addonId = "78272b6fa58f4a1abaac99321d503a20@proton.me";

    url = "https://addons.mozilla.org/firefox/downloads/file/4379392/proton_pass-1.24.1.xpi";
    sha256 = "1290a7d3b91204fae8f392c8dd4b3f62e4fa0182ae98de1d0042280af744be80";

    meta = {
      homepage = "https://proton.me";
      license = licenses.gpl3;
      mozPermissions = [
        "activeTab"
        "alarms"
        "scripting"
        "storage"
        "unlimitedStorage"
        "webRequest"
        "webRequestBlocking"
        "https://*/*"
        "http://*/*"
        "https://account.proton.me/*"
        "https://pass.proton.me/*"
      ];
    };
  };
}
