<div color='#7aaaff' > <h1>❄️【 NIXOS DOTFILES 】❄️</h1> </div>

- mirrors:
  - [git.sr.ht](https://git.sr.ht/~neverness/ultima)
  - [sij.ai](https://sij.ai/uwugdeeee/ultima)

> GUIDE FOR CREATE OWN MACHINE & HOME

1. Create directory with your [hostName](./machines/jetpure) in [flakeDir](./)

2. Create [default.nix](./machines/jetpure/default.nix) in [flakeDir/hostName](./machines/jetpure)

- Fill it with: [example](./machines/embrace/default.nix)

  ```nix
     { inputs, lib, ... }:
     {
       flake = import ../../libx {
         inherit inputs lib;
         # variables
         hostName = "pantheon"; # hostName is ~/flakeDir/hostName
         userName = "arthemida"; # userName
         flakeDir = "/persist/flake"; # flakeDir
         is = "desktop"; # for laptop | desktop | server
         # ricing
         theme = "chanivibes"; # from inputs.design.base16
         image = "default"; # from inputs.design.wallpapers
         # sys
         plfrm = "x86_64-linux"; # your architecture
         ver = "24.05"; # stateVersion
       };
     }
  ```

<details>
  <summary>Software</summary>

|                                                         wm & tools |                     |
| -----------------------------------------------------------------: | :------------------ |
|                     [hyprland](https://github.com/hyprwm/hyprland) | best window manager |
|                       [kitty](https://github.com/kovidgoyal/kitty) | good terminal       |
| [grimblast](https://github.com/hyprwm/contrib/tree/main/grimblast) | screenshoter        |
|                            [tofi](https://github.com/philj56/tofi) | gnome-like launcher |
|                        [waybar](https://github.com/Alexays/Waybar) | bar for wayland     |
|                           [mako](https://github.com/emersion/mako) | Notifications       |

|                                                 cli utilites |                                    |
| -----------------------------------------------------------: | :--------------------------------- |
|      [fastfetch](https://github.com/fastfetch-cli/fastfetch) | fetch for be cool rices            |
|             [fish](https://github.com/fish-shell/fish-shell) | just working shell                 |
|                  [eza](https://github.com/eza-community/eza) | rusted ls with icons               |
|                       [yazi](https://github.com/sxyazi/yazi) | rusted file-manager great!!!       |
|               [helix](https://github.com/helix-editor/helix) | best text editor with vi-like keys |
|                     [cava](https://github.com/karlstav/cava) | sound visualizer                   |
|             [lutgen](https://github.com/ozwaldorf/lutgen-rs) | rusted lut                         |
|               [jpegoptim](https://github.com/tjko/jpegoptim) | low size for jpeg                  |
|                      [nvtop](https://github.com/Syllo/nvtop) | top for GPU                        |
|                 [btop](https://github.com/aristocratos/btop) | very informated top                |
|         [trashy](https://github.com/oberblastmeister/trashy) | trash manager                      |
|                     [fuc](https://github.com/SUPERCILEX/fuc) | rusted cp and rm commands          |
| [sudo-rs](https://github.com/trifectatechfoundation/sudo-rs) | fast and secure sudo               |

|                                              gui utilites |                                                             |
| --------------------------------------------------------: | :---------------------------------------------------------- |
| [qutebrowser](https://github.com/qutebrowser/qutebrowser) | keyboard-driven, vim-like browser (best my opinion)         |
|                 [secrets](https://apps.gnome.org/Secrets) | manage your .kdbx vaults with libadwaita                    |
|       [syncthing](https://github.com/syncthing/syncthing) | synchronize folders/files via devices                       |
|                [libreoffice](https://www.libreoffice.org) | office suite                                                |
|             [vesktop](https://github.com/Vencord/Vesktop) | wayland Discord client                                      |
|                 [komikku](https://apps.gnome.org/Komikku) | read comics and manga                                       |
|                [zathura](https://github.com/pwmt/zathura) | read pdf and comix                                          |
|                            [spotify](https://spotify.com) | good music streamer                                         |
|                        [spicetify](https://spicetify.app) | modder for spotify                                          |
| [qbittorrent](https://github.com/qbittorrent/qBittorrent) | torrents))))) hahah))))                                     |
|      [ayugram](https://github.com/AyuGram/AyuGramDesktop) | i hate read deleted message >:(                             |
|        [64gram](https://github.com/TDesktop-x64/tdesktop) | idk just modified tgram client lol                          |
|       [walogram](https://codeberg.org/thirtysix/walogram) | generate telegram theme on stylix (nix verison in my files) |
|                [filezilla](https://filezilla-project.org) | good FTP client                                             |
|                  [mpv](https://github.com/mpv-player/mpv) | simplest video player                                       |
|              [anime4k](https://github.com/bloc97/Anime4K) | anime upscaler                                              |
|            [swayimg](https://github.com/artemsen/swayimg) | simple image viewer                                         |

|                                                           games |                                                  |
| --------------------------------------------------------------: | :----------------------------------------------- |
|                                                          native |                                                  |
|                [mindustry](https://github.com/Anuken/Mindustry) | OHMYGOD 10/10 RTS YEEEE BOYYYY                   |
|                                    [srb2](https://www.srb2.org) | classic 3d sonix                                 |
|                            [openarena](http://www.openarena.ws) | quake 3 with mods!!!                             |
|                                                        via wine |                                                  |
|               [bottles](https://github.com/bottlesdevs/Bottles) | wine launcher with multiple prefixes             |
| [prismlauncher](https://github.com/PrismLauncher/PrismLauncher) | fuckm all my homies plays this shit man          |
|                         [steam](https://store.steampowered.com) | cool game store and launcher                     |
|                [legendary](https://github.com/derrod/legendary) | cli for Epic Games Store                         |
|            [protonup](https://github.com/DavidoTek/ProtonUp-Qt) | provides Proton-GE/Wine-GE for Steam and Bottles |

|                                                  misc |                                       |
| ----------------------------------------------------: | :------------------------------------ |
|       [nix-tree](https://github.com/utdemir/nix-tree) | tree for your generations&derivations |
| [nix-init](https://github.com/nix-community/nix-init) | easy nix package creator              |
|         [nurl](https://github.com/nix-community/nurl) | tool for fetching git repo            |
|           [tenki](https://github.com/ckaznable/tenki) | tui clock with effects                |
|  [jetbrains](https://github.com/ryanoasis/nerd-fonts) | nerded fonts                          |

- IDK WHAT ALSO DUDES

</details>

> PREVIEW

![aye](https://git.sr.ht/~neverness/design/blob/wallpapers/dotfiles/fetch.jpg)

![aye](https://git.sr.ht/~neverness/design/blob/wallpapers/dotfiles/brows.jpg)

![aye](https://git.sr.ht/~neverness/design/blob/wallpapers/dotfiles/btop.jpg)

![aye](https://git.sr.ht/~neverness/design/blob/wallpapers/dotfiles/misc.jpg)

> thanks for [hezaki](https://codeberg.org/Hezaki/Touka), [maxmurr](https://github.com/TheMaxMur/NixOS-Configuration), [artem](https://github.com/ArtemChandragupta/NixFlake)
