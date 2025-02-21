{
  pkgs,
  ...
}:

with pkgs;
let
  mk =
    p:
    mkShell {
      shellHook = ''exec fish'';
      packages = p;
    };
in

{
  nixDev = mk [
    nixfmt-rfc-style
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
}
