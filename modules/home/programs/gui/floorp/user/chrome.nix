{ x, config, ... }:
with x;
{
  programs.floorp.profiles.${userName}.userChrome =
    let
      font = config.stylix.fonts;
    in
    # css
    ''
      * {
         font-family: "${font.monospace.name}" !important;
         font-size: 12pt !important;
       }
    '';
}
