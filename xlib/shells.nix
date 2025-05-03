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
}
