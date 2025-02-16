{
  lib,
  ...
}:

{
  imports = lib.x.baseName (
    lib.x.umport {
      path = ./.;
      exclude = [ ./default.nix ];
    }
  );
}
