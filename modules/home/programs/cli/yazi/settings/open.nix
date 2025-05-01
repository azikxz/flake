let
  gen = import ./gen.nix;
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
in

{
  prepend_rules = [
    (mkName "*.kdbx" [
      "kdbx"
    ])
    (mkName "*.exe" [
      "exe"
    ])
  ];
  rules =
    gen.ext
    ++ gen.app
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
    ++ (map
      (
        n:
        (mkMime n [
          "edit"
          "open"
        ])
      )
      [
        "inode/empty"
        "application/json"
        "application/x-ruby"
        "application/x-yaml"
        "application/x-shellscript"
        "application/x-docbook+xml"
        "*/javascript"
        "text/*"
        "*/"
      ]
    );
}
