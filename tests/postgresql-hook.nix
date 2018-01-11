{ stdenv, nixpkgs-overlay }:

stdenv.mkDerivation {
  name = "postgresql-hook-test";
  buildInputs = [ nixpkgs-overlay.postgresqlHook ];

  unpackPhase = ":";

  doCheck = true;

  checkPhase = ''
    echo '\l' | psql -U postgres -p $postgresqlPort
  '';

  installPhase = ''
    touch $out
  '';
}
