{
  pkgs,
  lib,
  ...
}:

with pkgs;
let

in

linkFarmFromDrvs "mods" (
  (lib.attrValues {
    FabricProxy-Lite = fetchurl {
      url = "https://cdn.modrinth.com/data/8dI2tmqs/versions/nR8AIdvx/FabricProxy-Lite-2.11.0.jar";
      sha512 = "c2e1d9279f6f19a561f934b846540b28a033586b4b419b9c1aa27ac43ffc8fad2ce60e212a15406e5fa3907ff5ecbe5af7a5edb183a9ee6737a41e464aec1375";
    };

    Fabric-API = fetchurl {
      url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/iHrvVvaM/fabric-api-0.134.0%2B1.21.9.jar";
      sha512 = "6f2c8d7aa311b90af2d80a4a9de18f22e3a19ebe22cf115278eabd3d397725bc706e98827c9eed20f9d751d4701e1da1cdf7258b90f77e65148a7a0133a1e336";
    };

    # QOL mods
    Simple-Voice-Chat = fetchurl {
      url = "https://cdn.modrinth.com/data/9eGKb6K1/versions/pTfXZIdn/voicechat-fabric-1.21.9-2.6.4.jar";
      sha512 = "234e5dbbad40a56546c5897995b9ac81bac11fa7478537f02e55a555af261783947b9695a5eb476173c0534248a46bb78040de16d4b831c4fc500c0406ac4e2a";
    };
  })
  + [ ]
)
