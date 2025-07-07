{ pkgs, lib }:

let
  interface = "wg0";

  awg = lib.getExe' pkgs.amneziawg-tools "awg";
  awg-quick = lib.getExe' pkgs.amneziawg-tools "awg-quick";
in

pkgs.writeScript "awg-ctl" ''
  set -euo pipefail

  status=$(sudo ${awg} show | grep -q '${interface}' && echo "up" || echo "down")

  case "''${1:-}" in
    show)
      echo "{\"text\": \"󰌆 \", \"tooltip\": \"${interface}: $status\", \"class\": \"$status\"}"
      ;;

    toggle)
      if [ "$status" = "up" ]; then
        sudo ${awg-quick} down ${interface}
        status="down"
        bool="false"
      else
        sudo ${awg-quick} up ${interface}
        status="up"
        bool="true"
      fi
      notify-send \
        "${interface}" \
        "$status" \
        -i "network-vpn-symbolic"
      ;;

  esac
''
