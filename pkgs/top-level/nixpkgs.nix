{ rev, sha256, system ? builtins.currentSystem }:

let
  builtin-paths = import <nix/config.nix>;

  tarball = import <nix/fetchurl.nix> {
    url = "https://github.com/NixOS/nixpkgs/archive/${rev}.tar.gz";
    inherit sha256;
  };

  script = builtins.toFile "builder.sh" ''
    "$coreutils/mkdir" "$out"
    cd "$out"
    "$gzip" --decompress < "$tarball" | "$tar" -x --strip-components=1
  '';

  nixpkgs = derivation {
    name = "nixpkgs-${builtins.substring 0 6 rev}";
    builder = builtins.storePath builtin-paths.shell;
    args = [ script ];

    coreutils = builtins.storePath builtin-paths.coreutils;
    gzip      = builtins.storePath builtin-paths.gzip;
    tar       = builtins.storePath builtin-paths.tar;

    inherit tarball system;
  };
in
  nixpkgs
