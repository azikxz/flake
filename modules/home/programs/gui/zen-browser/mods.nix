{
  pkgs,
  ...
}:

let
  mods = pkgs.fetchFromGitHub {
    owner = "zen-browser";
    repo = "theme-store";
    rev = "21e5f9ab7525bde8a5326f51f448afb45468024e";
    hash = "sha256-B5Ug/7lzivDs6FGa9euINGjP8j/tp4wBsTYckOb6OlI=";
  };
in

{

}
