{
  stdenv,
  fetchurl,
  autoPatchelfHook,
  ver,
}:
stdenv.mkDerivation {
  name = "keydex";

  dontUnpack = true;
  nativeBuildInputs = [ autoPatchelfHook ];

  src = fetchurl {
    url = "https://github.com/shikaan/keydex/releases/download/v${ver}/keydex-linux-amd64";
    sha256 = "sha256-f/H6xKqmQWaT99Ln/dN8VodvfUyLAL8wtSLA7jm7j08=";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/keydex
    chmod +x $out/bin/keydex
  '';

  postInstall = ''
    installShellCompletion --cmd keydex \
      --bash <($out/bin/keydex completions bash) \
      --fish <($out/bin/keydex completions fish) \
      --zsh <($out/bin/keydex completions zsh)
  '';
}
