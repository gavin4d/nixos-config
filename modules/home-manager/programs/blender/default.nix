{pkgs, ...}:
{
  home.packages = with pkgs; [
    blender
    qcad
    kdePackages.kdenlive
    audacity
    bambu-studio
    # aseprite
    # prusa-slicer
  ];
}
