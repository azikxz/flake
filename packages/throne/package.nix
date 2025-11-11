{
  pkgs,
  lib,
}:

pkgs.stdenv.mkDerivation (finalAttrs: {
  pname = "throne";
  version = "1.0.8-unstable-2025-10-29";

  src = pkgs.fetchFromGitHub {
    owner = "throneproj";
    repo = "Throne";
    rev = "54af50fc414ffaf98b3ff88e3dd8aa041c65e041";
    hash = "sha256-kfvsGw0RUYHkOUSeSA4egLl+gQqN4KkZKXX3CQQzYks=";
  };

  strictDeps = true;

  nativeBuildInputs = with pkgs; [
    cmake
    copyDesktopItems
    ninja
    qt6Packages.wrapQtAppsHook
  ];

  buildInputs = with pkgs; [
    qt6Packages.qtbase
    qt6Packages.qttools
  ];

  cmakeFlags = [ (lib.cmakeBool "NKR_PACKAGE" true) ];

  patches = [ ./nixos-disable-setuid-request.patch ];

  preBuild = ''
    ln -s ${
      pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/throneproj/routeprofiles/60eb41122de3aa53c701ec948cd52d7a26adafea/srslist.h";
        hash = "sha256-k9vPtcusML4GR81UVeJ7jhuDHGk5Qh0eKw/cSOxBd5g=";
      }
    } ./srslist.h
  '';

  installPhase = ''
    runHook preInstall

    install -Dm755 Throne -t "$out/share/throne/"
    install -Dm644 "$src/res/public/Throne.png" -t "$out/share/icons/hicolor/512x512/apps/"

    mkdir -p "$out/bin"
    ln -s "$out/share/throne/Throne" "$out/bin/"

    ln -s ${finalAttrs.passthru.core}/bin/Core "$out/share/throne/Core"

    runHook postInstall
  '';

  desktopItems = [
    (pkgs.makeDesktopItem {
      name = "throne";
      desktopName = "Throne";
      exec = "Throne";
      icon = "Throne";
      comment = finalAttrs.meta.description;
      terminal = false;
      categories = [ "Network" ];
    })
  ];

  passthru.core = pkgs.buildGoModule {
    pname = "throne-core";
    inherit (finalAttrs)
      version
      src
      ;

    sourceRoot = "${finalAttrs.src.name}/core/server";

    patches = [ ./core-also-check-capabilities.patch ];

    proxyVendor = true;
    vendorHash = "sha256-thMRkbs5fS7KsUSRSeUaB2xkTjs7kJ9AKXW0+OXN3io=";

    nativeBuildInputs = with pkgs; [
      protobuf
      protoc-gen-go
      (pkgs.callPackage ../protorpc.nix { })
    ];

    preBuild = ''
      pushd gen
      protoc -I . --go_out=. --protorpc_out=. libcore.proto
      popd
    '';

    ldflags = [
      "-w"
      "-s"
      "-X github.com/sagernet/sing-box/constant.Version=${finalAttrs.version}"
    ];

    tags = [
      "with_clash_api"
      "with_gvisor"
      "with_quic"
      "with_wireguard"
      "with_utls"
      "with_dhcp"
      "with_tailscale"
    ];
  };

  passthru = {
    inherit (finalAttrs.passthru.core)
      goModules
      ;
  };

  meta = {
    description = "Qt based cross-platform GUI proxy configuration manager";
    homepage = "https://github.com/throneproj/Throne";
    license = lib.licenses.gpl3Plus;
    mainProgram = "Throne";
    maintainers = with lib.maintainers; [
      tomasajt
      aleksana
      azikx
    ];
    platforms = lib.platforms.linux;
  };
})
