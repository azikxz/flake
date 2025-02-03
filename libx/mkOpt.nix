{ lib, ... }:
with lib;
let
  nu = types.nullOr;
in
rec {
  # types and mk*
  mkOpt = type: default: mkOption { inherit type default; };
  mkBool = mkOpt types.bool;
  mkStr = mkOpt types.str;
  mkPkg = mkOpt types.package;
  mkInt = mkOpt types.int;
  mkEnum = mkOpt types.enum;
  # mk two sided idk
  mkList = {
    pkgs = mkOpt (types.listOf types.package);
    str = mkOpt (types.listOf types.str);
  };
  mkAttrs = {
    pkgs = mkOpt (types.attrsOf types.package);
    str = mkOpt (types.attrsOf types.str);
    any = mkOpt (types.attrsOf types.anything);
  };
  mkNull = {
    bool = mkOpt (nu types.bool);
    str = mkOpt (nu types.str);
    pkg = mkOpt (nu types.package);
    int = mkOpt (nu types.int);
    enum = mkOpt (nu types.enum);
  };
}
