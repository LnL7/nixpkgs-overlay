{ config ? {}, overlays ? [], system ? builtins.currentSystem
, nixpkgs ? <nixpkgs>
, nixpkgsArgs ? {
    inherit config system;
    overlays = [ (import ./nixpkgs-overlay.nix) ] ++ overlays;
  }
}:

import nixpkgs nixpkgsArgs
