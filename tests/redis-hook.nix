{ stdenv, nixpkgs-overlay }:

stdenv.mkDerivation {
  name = "redis-hook-test";
  buildInputs = [ nixpkgs-overlay.redisHook ];

  unpackPhase = ":";

  doCheck = true;

  checkPhase = ''
    redis-cli -p $redisPort ping
  '';

  installPhase = ''
    touch $out
  '';
}

