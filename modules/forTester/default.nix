{
  lib,
  ...
}:

# INFO:
# tester for some programs etc...

{
  imports = [
    ../misc/locales/default.nix
    ../misc/minimal/default.nix
    ../misc/nix/default.nix
  ];

  users.users.tester = {
    isNormalUser = true;

    home = "/home/tester";
    createHome = true;

    initialHashedPassword = lib.mkForce "$2b$05$vfFJcNMZaHujKhPSERV/o.nLa2GqYlM0e8ovlfwnhj4XdOJ3Gv7h2";

    description = "beta tester for programs";
  };
}
