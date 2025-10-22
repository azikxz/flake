{
  pkgs,
  lib,
}:

pkgs.stdenv.mkDerivation (finalAttrs: {
  pname = "throne";
  version = "1.0.6";

  src = pkgs.fetchFromGitHub {
    owner = "throneproj";
    repo = "Throne";
    tag = finalAttrs.version;
    hash = "sha256-SWTbqyPGoEk8vAbkE1PWqkPbpRNRcIYRW1UY5r137VM=";
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

  NIX_CFLAGS_COMPILE = "-I${finalAttrs.passthru.routeprofiles}";

  cmakeFlags = [ (lib.cmakeBool "NKR_PACKAGE" true) ];

  patches = [ ./nixos-disable-setuid-request.patch ];

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
    vendorHash = "sha256-QmpNWxytWZ+ii77OFYeNcO83gJ16V/IYDE+ST+5Wxww=";

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

  passthru.routeprofiles = pkgs.fetchFromGitHub {
    owner = "throneproj";
    repo = "routeprofiles";
    rev = "28bf25d624e786cba3704efdd1e696ec502cd123";
    postFetch = ''
      rm $out/list # we only need srslist.h
    '';
    hash = "sha256-N2UEdEI4ekNixvtlxebxw+jLq7//3vUzfn2qpMvzS6k=";
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
    maintainers = with lib.maintainers; [ tomasajt ];
    platforms = lib.platforms.linux;
  };
})
