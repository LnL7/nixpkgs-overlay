self: super:

{
  nixpkgs-overlay = {

    postgresqlHook = super.callPackage ./pkgs/postgresql-hook {};

  };
}
