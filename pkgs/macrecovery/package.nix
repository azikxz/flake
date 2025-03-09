{ pkgs }:

pkgs.writeScriptBin "macrecovery" (
  builtins.readFile (
    pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/acidanthera/OpenCorePkg/refs/heads/master/Utilities/macrecovery/macrecovery.py";
      sha256 = "sha256-aO3GxEt/K2W7I9XlCDzRInp/UvS/qnFvf6pY0lvlVLk=";
    }
  )
)
