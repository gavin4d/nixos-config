{pkgs, ...}:
{
  home.packages = with pkgs; [
    blender
    aseprite
    qcad
    libsForQt5.kdenlive
    audacity
    bambu-studio
    prusa-slicer
  ];
}
