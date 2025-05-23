{
  lib,
  ...
}:

with lib;

rec {
  # types and mk*
  mkOpt =
    type: default:
    mkOption {
      inherit
        type
        default
        ;
    };
  mkBool = mkOpt (types.bool);
  mkStr = mkOpt (types.str);
  mkLines = mkOpt (types.lines);
  mkRaw = mkOpt (types.raw);
  mkPkg = mkOpt (types.package);
  mkInt = mkOpt (types.int);
  mkEnum = mkOpt (types.enum);
  mkPath = mkOpt (types.path);
  mkPort = mkOpt (types.port);
  mkOneOf = mkOpt (types.oneOf);
  mkUns = mkOpt (types.unspecified);
  mkAttrsOf = type: (types.attrsOf type);
  # mk two sided idk
  mkList =
    let
      mk = types.listOf;
    in
    {
      pkgs = mkOpt (mk types.package);
      str = mkOpt (mk types.str);
    };
  mkAttrs =
    let
      mk = types.attrsOf;
    in
    {
      pkgs = mkOpt (mk types.package);
      str = mkOpt (mk types.str);
      any = mkOpt (mk types.anything);
      attrs = mkOpt (mk types.attrs);
    };
  mkNull =
    let
      mk = types.nullOr;
    in
    {
      bool = mkOpt (mk types.bool);
      str = mkOpt (mk types.str);
      lines = mkOpt (mk types.lines);
      pkg = mkOpt (mk types.package);
      int = mkOpt (mk types.int);
      enum = mkOpt (mk types.enum);
      path = mkOpt (mk types.path);
      port = mkOpt (mk types.port);
    };
}
