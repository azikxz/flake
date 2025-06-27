{
  lib,
  ...
}:

with lib;

mkIf false {
  hm = {
    programs.foliate = {
      enable = true;
    };

    xdg.dataFile = {
      "com.github.johnfactotum.Foliate/catalogs/catalogs.json".text = builtins.toJSON {
        catalogs = [
          {
            title = "Internet Archive";
            uri = "https://bookserver.archive.org/catalog";
          }
          {
            title = "Flibusta";
            uri = "http://flibusta.is/opds";
          }
          {
            title = "Samlib";
            uri = "http://opdshome.uo1.net/samlib";
          }
        ];
      };
    };
  };
}
