{ config, pkgs, lib, ... }:
{
  # [...]
  nixpkgs.overlays = [ (final: prev: {
    ELRS = pkgs.callPackage ./ELRS.nix {};  
  }) ];
  home.packages = [
    pkgs.ELRS
  ];
}
