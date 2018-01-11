self: super:

{
  nixpkgs-overlay = super.recurseIntoAttrs {
    postgresqlHook = super.callPackage ./pkgs/postgresql-hook {};

    tests = super.recurseIntoAttrs {
      postgresqlHook = super.callPackage ./tests/postgresql-hook.nix {};
    };
  };
}
