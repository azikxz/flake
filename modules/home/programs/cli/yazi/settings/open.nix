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
      (mkName "*/" [
        "edit"
        "open"
      ])
      (mkMime "text/*" [
        "edit"
        "open"
      ])
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
          "office"
        ])
      )
      [
        "*.odt"
        "*.xlsx"
        "*.xlt"
        "*.xlw"
        "*.pptx"
        "*.docx"
      ]
    );
}
