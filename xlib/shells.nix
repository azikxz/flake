{
  pkgs,
}:

with pkgs;
let
  mk =
    packages:
    mkShell {
      shellHook = ''exec fish'';
      inherit packages;
    };
in

{
  nixDev = mk [
    nixfmt-rfc-style
    nix-init
    cachix
  ];
  rust = mk [
    rustfmt
    rustc
    cargo
  ];
  python = mk [
    python3
    pipx
  ];
  alloy =
    let
      alloy6' = pkgs.stdenv.mkDerivation rec {
        pname = "alloy${lib.versions.major version}";
        version = "6.2.0";

        src = pkgs.fetchurl {
          sha256 = "sha256-a4wctbyTvt/HxhQ1xOGrbmiKJC3HAqOUYo2amAHtt40=";
          url = "https://github.com/AlloyTools/org.alloytools.alloy/releases/download/v${version}/org.alloytools.alloy.dist.jar";
        };

        nativeBuildInputs = [ pkgs.makeWrapper ];
        buildCommand = ''
          jar=$out/share/alloy/${pname}.jar
          install -Dm644 ${src} $jar

          mkdir -p $out/bin
          makeWrapper ${pkgs.jre}/bin/java $out/bin/${pname} --add-flags \
            "-jar $jar"
        '';
      };
    in
    mk [
      alloy6'
    ];
}
