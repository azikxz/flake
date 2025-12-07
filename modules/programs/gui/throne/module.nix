{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.programs.throne;
in
# INFO: taken from
# https://github.com/amirhossein-fzl/nixos-config/blob/main/modules/custom/throne/default.nix

{
  options = {
    programs.throne = {
      enable = mkEnableOption "throne, a GUI proxy configuration manager";

      package = mkPackageOption pkgs "throne" { nullable = true; };

      tunMode = {
        enable = mkEnableOption "TUN mode of throne";

        setuid = mkEnableOption ''
          setting suid bit for throne to run as root, which is less
          secure than default setcap method but closer to upstream assumptions.
          Enable this if you find the default setcap method configured in
          this module doesn't work for you
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];

    security.wrappers = {
      throne-core = mkIf cfg.tunMode.enable {
        source = "${cfg.package}/share/throne/Core";

        owner = "root";
        group = "root";
        setuid = mkIf cfg.tunMode.setuid true;

        capabilities = mkIf (
          !cfg.tunMode.setuid
        ) "cap_net_admin,cap_net_raw,cap_net_bind_service,cap_sys_ptrace,cap_dac_read_search+ep";
      };
    };

    security.polkit.extraConfig =
      mkIf (cfg.tunMode.enable && (!cfg.tunMode.setuid) && config.services.resolved.enable)
        ''
          polkit.addRule(function(action, subject) {
            const allowedActionIds = [
              "org.freedesktop.resolve1.set-domains",
              "org.freedesktop.resolve1.set-default-route",
              "org.freedesktop.resolve1.set-dns-servers"
            ];

            if (allowedActionIds.indexOf(action.id) !== -1) {
              try {
                var parentPid = polkit.spawn(["${getExe' pkgs.procps "ps"}", "-o", "ppid=", subject.pid]).trim();
                var parentCap = polkit.spawn(["${getExe' pkgs.libcap "getpcaps"}", parentPid]).trim();
                if (parentCap.includes("cap_net_admin") && parentCap.includes("cap_net_raw")) {
                  return polkit.Result.YES;
                } else {
                  return polkit.Result.NOT_HANDLED;
                }
              } catch (e) {
                return polkit.Result.NOT_HANDLED;
              }
            }
          })
        '';
  };

  meta.maintainers = with lib.maintainers; [ azikx ];
}
