{
  lib,
  config,
  ...
}:

with lib;
let
  inherit (config.sops)
    placeholder
    secrets
    ;
in

{
  options = {
    sopsnix = mkOption {
      type = types.attrsOf types.str;
      default = { };
      description = "Shortcut paths to sopsnix secrets";
    };

    sopstem = {
      content = mkOption {
        type = types.attrsOf types.lines;
        default = { };
        description = "Templates to sopsnix secrets (inline content)";
      };

      file = mkOption {
        type = types.attrsOf types.path;
        default = { };
        description = "Templates to sopsnix secrets (file paths)";
      };
    };

    sopsplace = mkOption {
      type = types.attrsOf types.str;
      default = { };
      description = "Placeholders for secrets (used before decryption)";
    };
  };

  config = {
    sopsnix = mapAttrs (n: _: secrets.${n}.path) secrets;

    sopsplace = config.sops.placeholder;

    sops.templates =
      let
        contentTemplates = mapAttrs (_: content: {
          inherit
            content
            ;
        }) config.sopstem.content;

        fileTemplates = mapAttrs (_: file: {
          inherit
            file
            ;
        }) config.sopstem.file;
      in
      mkMerge [
        contentTemplates
        fileTemplates
      ];
  };
}
