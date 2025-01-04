{ ... }:
{
  programs.fish =
    let
      # VARIABLES
      col = "set fish_color";
      pag = "set fish_pager_color";
      sel = "${pag}_selected";
      sec = "${pag}_secondary";
      bol = "--bold";
      ita = "--italics";
      bg = "--background";
      # COLORS
      colors = ''
        # COLORS
        ${col}_cancel       ${bg}=red ${bol} black
        ${col}_comment      gray
      '';
      pager = ''
        # COMPLETIONS
        ${pag}_completion   white
        ${sel}_completion   black ${bol}
        ${sec}_completion   white
        ${pag}_prefix       white
        ${sel}_prefix       black  ${bol}
        ${pag}_description  yellow ${ita}
        ${sel}_description  black
        ${pag}_background   black
        ${sel}_background   ${bg}=green
        ${pag}_progress     ${bg}=magenta black
      '';
    in
    {
      interactiveShellInit = ''
        ${colors}
        ${pager}
      '';
    };
}
