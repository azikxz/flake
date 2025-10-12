{
  pkgs,
  lib,
  ...
}:

with lib;
let
  fix = ''s/\x74\x11\xe8\x21\x23\x00\x00/\xeb\x11\xe8\x21\x23\x00\x00/g'';
in
# WARN: it will be very very long (6~ gb for 20.0)

mkIf false {
  persist.user.dirs = [
    ".local/share/DaVinciResolve"
    ".local/state/DaVinciResolve"
  ];

  hmPackages = with pkgs; [
    (old.davinci-resolve-studio.override (old: {
      buildFHSEnv =
        fhs:
        (
          let
            davinci = fhs.passthru.davinci.overrideAttrs (old: {
              postFixup = ''
                ${old.postFixup}
                ${getExe perl} -pi -e '${fix}' $out/bin/resolve
              '';
            });
          in
          old.buildFHSEnv (
            fhs
            // {
              extraBwrapArgs = [
                ''--bind "$HOME"/.local/share/DaVinciResolve/license ${davinci}/.license''
                # "--bind /run/opengl-driver/etc/OpenCL /etc/OpenCL"
              ];

              runScript = "${getExe bash} ${writeText "davinci-wrapper" ''
                export QT_XKB_CONFIG_ROOT="${xkeyboard_config}/share/X11/xkb"

                export QT_PLUGIN_PATH="${davinci}/libs/plugins:$QT_PLUGIN_PATH"

                export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib:/usr/lib32:${davinci}/libs

                unset QT_QPA_PLATFORM # Having this set to wayland causes issues

                ${davinci}/bin/resolve
              ''}";

              extraInstallCommands = ''
                mkdir -p $out/share/applications $out/share/icons/hicolor/128x128/apps

                ln -s ${davinci}/share/applications/*.desktop $out/share/applications/

                ln -s ${davinci}/graphics/DV_Resolve.png $out/share/icons/hicolor/128x128/apps/davinci-resolve-studio.png
              '';

              passthru = {
                inherit
                  davinci
                  ;
              };
            }
          )
        );
    }))
  ];
}
