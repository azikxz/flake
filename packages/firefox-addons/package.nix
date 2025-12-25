{
  buildFirefoxXpiAddon,
  fetchurl,
  lib,
  stdenv,
}:
{
  "torrserver-adder" = buildFirefoxXpiAddon {
    pname = "torrserver-adder";
    version = "2.0.5";
    addonId = "84z74tXJKt8OUrTD@TSA";
    url = "https://addons.mozilla.org/firefox/downloads/file/4264581/torrserver_adder-2.0.5.xpi";
    sha256 = "6783c13fe423c14fbf9dd23ea3232167dc78eeb298594ab802aa9a7b094fb365";
    meta = with lib; {
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
      platforms = platforms.all;
    };
  };
}
