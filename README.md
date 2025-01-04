<div align="center"> <h1>❄️【 NIXOS DOTFILES 】❄️</h1> </div>

### GUIDE FOR CREATE OWN MACHINE & HOME

1. Create directory with your _hostName_ in _flakeDir_

- _flakeDir_ is flake root (example: **/persist/flake/** )

2. Create _default.nix_ in ~/_flakeDir_/_hostName_/ (example: **~/flakeDir/hostName/default.nix** )

- Fill it with:
  ```nix
    { inputs, lib, ... }:
    {
      flake = import ../libx/builder.nix { # default values watch in ~/flakeDir/libx/builder.nix
        inherit inputs lib;
        disk = "..."; # your disk in /dev/disk/by-uuid/*
        # VARIABLES
        hostName = "pantheon"; # hostName is ~/flakeDir/hostName
        userName = "arthemida"; # userName
        flakeDir = "/persist/flake"; # flakeDir
        is = "desktop"; # for laptop | desktop | server
        # CUSTOMIZE
        theme = "chanivibes"; # from inputs.design.base16
        image = "default"; # from inputs.design.wallpapers
        # SYS INFA
        plfrm = "x86_64-linux"; # your architecture
        ver = "24.05"; # stateVersion in below /etc/nixos/configuration.nix
        # DEVICES
        dev = { # other mountable disks
          SSD1 = "/mnt/games";
          HDD1 = "/mnt/prono_idk";
          SSD2 = "/mnt/howii";
        };
      };
    }
  ```

<details>
  <summary>Software</summary>

|                                              Category (name + url) | Desciption                                       |
| -----------------------------------------------------------------: | ------------------------------------------------ |
|                                                    Window managers |                                                  |
|                     [hyprland](https://github.com/hyprwm/hyprland) | Best window manager                              |
|                       [kitty](https://github.com/kovidgoyal/kitty) | Very good terminal with image preview            |
| [grimblast](https://github.com/hyprwm/contrib/tree/main/grimblast) | Screenshoter                                     |
|              [nwg-drawer](https://github.com/nwg-piotr/nwg-drawer) | Gnome-like launcher                              |
|                        [waybar](https://github.com/Alexays/Waybar) | Bar for wayland compositors                      |
|                                                       CLI utilites |                                                  |
|                   [fish](https://github.com/fish-shell/fish-shell) | Just working shell                               |
|            [fastfetch](https://github.com/fastfetch-cli/fastfetch) | Fetch for be cool rices                          |
|                             [yazi](https://github.com/sxyazi/yazi) | Rusted file-manager great!!!                     |
|                     [helix](https://github.com/helix-editor/helix) | Best text editor with vi-like keys               |
|                           [cava](https://github.com/karlstav/cava) | Sound visualizer                                 |
|               [rustmission](https://github.com/intuis/rustmission) | TUI for Transmission                             |
|                        [eza](https://github.com/eza-community/eza) | Rusted ls with icons                             |
|                               [lsd](https://github.com/lsd-rs/lsd) | Rusted ls with icons (idk another?)              |
|                   [lutgen](https://github.com/ozwaldorf/lutgen-rs) | Rusted lut                                       |
|                     [jpegoptim](https://github.com/tjko/jpegoptim) | Low size for jpeg                                |
|                         [optipng](https://optipng.sourceforge.net) | Low size for png                                 |
|                            [nvtop](https://github.com/Syllo/nvtop) | Top for GPU                                      |
|                       [btop](https://github.com/aristocratos/btop) | Very informated top                              |
|               [trashy](https://github.com/oberblastmeister/trashy) | Trash manager                                    |
|                           [fuc](https://github.com/SUPERCILEX/fuc) | Rusted cp and rm commands                        |
|       [sudo-rs](https://github.com/trifectatechfoundation/sudo-rs) | Fast and secure sudo                             |
|                                                       GUI utilites |                                                  |
|                      [zen](https://github.com/zen-browser/desktop) | Stylish and modern ForryFox (best my opinion)    |
|                [floorp](https://github.com/Floorp-Projects/Floorp) | One of best browser on FurryFox                  |
|                            [qutebrowser](https://qutebrowser.org/) | Cool browser with vi keys                        |
|                          [nemo](https://github.com/linuxmint/nemo) | File manager from Cinnamon                       |
|         [onlyoffice](https://github.com/ONLYOFFICE/DesktopEditors) | Office suite                                     |
|                      [vesktop](https://github.com/Vencord/Vesktop) | Wayland Discord client                           |
|          [qbittorrent](https://github.com/qbittorrent/qBittorrent) | Torrents))))) hahah))))                          |
|                 [64gram](https://github.com/TDesktop-x64/tdesktop) | IDK just modified tgram client lol               |
|               [ayugram](https://github.com/AyuGram/AyuGramDesktop) | Telegram client with ghost mode                  |
|          [file-Roller](https://gitlab.gnome.org/GNOME/file-roller) | Archiver                                         |
|                         [filezilla](https://filezilla-project.org) | Good FTP client                                  |
|                           [mpv](https://github.com/mpv-player/mpv) | Simplest video player                            |
|                       [anime4k](https://github.com/bloc97/Anime4K) | Anime upscaler                                   |
|                     [swayimg](https://github.com/artemsen/swayimg) | Simple image viewer                              |
|                                                              Games |                                                  |
|                   [mindustry](https://github.com/Anuken/Mindustry) | OHMYGOD 10/10 RTS YEEEE BOYYYY                   |
|                  [bottles](https://github.com/bottlesdevs/Bottles) | Wine launcher with multiple prefixes             |
|    [prismlauncher](https://github.com/PrismLauncher/PrismLauncher) | Fuckm all my homies plays this shit man          |
|                            [steam](https://store.steampowered.com) | Cool game store and launcher                     |
|                   [legendary](https://github.com/derrod/legendary) | CLI for Epic Games Store                         |
|               [protonup](https://github.com/DavidoTek/ProtonUp-Qt) | Provides Proton-GE/Wine-GE for Steam and Bottles |
|   [proton-ge](https://github.com/GloriousEggroll/proton-ge-custom) | GE(idk what that mean) version of Valve Proton   |
|                                                               Misc |                                                  |
|                    [nix-tree](https://github.com/utdemir/nix-tree) | Tree for your generations&derivations            |
|                      [nurl](https://github.com/nix-community/nurl) | Tool for fetching git repo                       |
|                        [tenki](https://github.com/ckaznable/tenki) | TUI clock with effects                           |
|                 [confetty](https://github.com/maaslalani/confetty) | Confetty and fireworks in terminal               |
|               [jetbrains](https://github.com/ryanoasis/nerd-fonts) | Nerded fonts                                     |

- IDK WHAT ALSO DUDES

</details>

### PREVIEW

![aye](https://git.sr.ht/~neverness/design/blob/main/dotfiles/workst/fetch.jpeg)

![ауе](https://git.sr.ht/~neverness/design/blob/main/dotfiles/workst/spotify.jpeg)

![ауе](https://git.sr.ht/~neverness/design/blob/main/dotfiles/workst/top.jpeg)

![ауе](https://git.sr.ht/~neverness/design/blob/main/dotfiles/workst/yazi.jpeg)

![ауе](https://git.sr.ht/~neverness/design/blob/main/dotfiles/workst/adam_yeee_father.jpeg)

#### ENGLISH OR SPANISH??? WHOEVER MOVES IS GAY)))))))

#### THANKS FOR [hezaki](https://codeberg.org/Hezaki/Touka/), [maxmurr](https://github.com/TheMaxMur/NixOS-Configuration), [artem](https://github.com/ArtemChandragupta/NixFlake)
