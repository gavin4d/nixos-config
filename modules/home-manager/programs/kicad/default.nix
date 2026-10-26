{pkgs, ...}:
# let
#   pkgs = import nixpkgs {
#     config = { };
#     overlays = [
#       (final: prev: { ltspice = prev.ltspice.override {
#         src = pkgs.fetchurl {
#           url = "https://web.archive.org/web/20251028221949/https://ltspice.analog.com/software/LTspice64.msi";
#           hash = "sha256-LSK84ogbBk9kP7LKg8rzCGDqq36XfsK4Kzn2Zwea8C4=";
#         };
#       };
#     })
#     ];
#     inherit system;
#   };
# in
let
  winepkg = import (pkgs.fetchFromGitHub{
    owner = "nixos";
    repo = "nixpkgs";
    rev = "nixos-24.11";
    sha256 = "sha256-/bVBlRpECLVzjV19t5KMdMFWSwKLtb5RyXdjz3LJT+g=";
  }) {system = "x86_64-linux";};
  ltspice = (pkgs.ltspice.override{
               wine64 = winepkg.wine64;
             }).overrideAttrs(_:{
               src = pkgs.fetchurl {
                 url = "https://ltspice.analog.com/software/LTspice64.msi";
                 hash = "sha256-2t/6idUniSRHLdJQ+5OuvcRNGRIs2PR0iiezpZ0ovY8=";
               };   
             });
in
{
  home.packages = with pkgs; [
    (kicad.override {
      compressStep = false;
    })
    msitools
    freetype
    winepkg.wineWowPackages.stable
    # ltspice
# (ltspice.override({
#                wine64 = winepkg.wine64;
#              })).overrideAttrs(_:{
#                src = pkgs.fetchurl {
#                  url = "https://web.archive.org/web/20251028221949/https://ltspice.analog.com/software/LTspice64.msi";
#                  hash = "sha256-r5P3kW/nDN99mbTklDrmegc3wfIoatmQC8HeAooemH8=";
#                };   
#              })
  ];
#  programs.kicad = {
#    enable = true;
#    catppuccin = {
#      flavour = "Latte";
#      enable = true;
#    };
#  };
}
