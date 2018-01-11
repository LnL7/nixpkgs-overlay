self: super:

{
  nixpkgs-overlay = super.recurseIntoAttrs {
    postgresqlHook = super.callPackage ./pkgs/postgresql-hook {};
    redisHook = super.callPackage ./pkgs/redis-hook {};

    tests = super.recurseIntoAttrs {
      postgresqlHook = super.callPackage ./tests/postgresql-hook.nix {};
      redisHook = super.callPackage ./tests/redis-hook.nix {};
    };
  };
}
