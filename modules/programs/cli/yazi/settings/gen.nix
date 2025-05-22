let
  _ = sum: ext: {
    name = sum + ext;
    use = [
      "extract"
      "reveal"
    ];
  };

  app = {
    gen = _ "application/";

    rule = [
      "zip"
      "gzip"
      "tar"
      "bzip"
      "bzip2"
      "7z-compressed"
      "rar"
      "xz"
    ];
  };

  ext = {
    gen = _ "*.";

    rule = [
      "7z"
      "ace"
      "ar"
      "arc"
      "bz2"
      "cab"
      "cpio"
      "cpt"
      "dgc"
      "dmg"
      "gz"
      "rar"
      "shar"
      "tar"
      "tgz"
      "xar"
      "xz"
      "zip"
    ];
  };
in

{
  app = with app; map gen rule;
  ext = with ext; map gen rule;
}
