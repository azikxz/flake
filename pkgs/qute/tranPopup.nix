{
  stdenv,
  fetchFromGitHub,
  python313Packages,
}:

stdenv.mkDerivation {
  name = "tranPopup";

  src = fetchFromGitHub {
    owner = "uwuwuwde";
    repo = "qute-translate-popup";
    rev = "7d239fc1078da12cc643c2065233cea54010bad2";
    hash = "sha256-lZzdS4pxjhBO1GdYfLok9ss8AwE9r0uD+m0+XVRngJ0=";
  };

  nativeBuildInputs = [ python313Packages.requests ];

  installPhase = ''install -Dm555 translate $out/exe'';
}
