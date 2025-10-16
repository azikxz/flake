let
  mkMime = mime: use: {
    inherit
      mime
      use
      ;
  };

  mkName = name: use: {
    inherit
      name
      use
      ;
  };

  gen = import ./gen.nix;
in

{
  prepend_rules = [
    (mkName "*.kdbx" [ "kdbx" ])
    (mkName "*.exe" [ "exe" ])
    (mkName "*.pdf" [ "pdf" ])
  ];

  rules =
    (gen.ext ++ gen.app)

    ++ [
      (mkMime "image/*" [
        "image"
        "open"
      ])

      (mkMime "{audio,video}/*" [
        "play"
        "open"
      ])
    ]

    ++ (map (n: (mkMime n [ "native" ])) [
      "application/executable"
      "application/pie-executable"
      "text/shellscript"

      "application/x-executable"
      "application/x-pie-executable"
      "text/x-shellscript"
    ])

    ++ (map (n: (mkMime n [ "office" ])) [
      "application/msword"
      "application/vnd.oasis.opendocument.text"
      "application/vnd.oasis.opendocument.text-template"
      "application/vnd.oasis.opendocument.text-web"
      "application/vnd.oasis.opendocument.text-master"
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document"

      "application/vnd.ms-excel"
      "application/vnd.oasis.opendocument.spreadsheet"
      "application/vnd.oasis.opendocument.spreadsheet-template"
      "application/vnd.oasis.opendocument.chart"
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      "text/csv"

      "application/vnd.ms-powerpoint"
      "application/vnd.oasis.opendocument.presentation"
      "application/vnd.oasis.opendocument.presentation-template"
      "application/vnd.openxmlformats-officedocument.presentationml.presentation"

      "application/vnd.oasis.opendocument.graphics"
      "application/vnd.oasis.opendocument.graphics-template"
      "application/vnd.oasis.opendocument.image"

      "application/vnd.oasis.opendocument.formula"
      "application/vnd.oasis.opendocument.database"
    ])

    ++ (map (n: (mkMime n [ "pdf" ])) [
      "application/pdf"
      "application/zip"

      "application/cbt"
      "application/cbr"
      "application/cbz"

      "application/x-cbt"
      "application/x-cbr"
      "application/x-cbz"
      "application/epub+zip"

      "application/vnd.comicbook-rar"
      "application/vnd.comicbook+zip"
    ])

    ++ (map (n: (mkMime n [ "edit" ])) [
      "inode/empty"
      "application/*"
      "text/*"
    ])
    ++ [ (mkMime "*/" [ "open" ]) ];
}
