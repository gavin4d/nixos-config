{pkgs, ...}:
{
  home.packages = with pkgs; [
    blender
    qcad
    libsForQt5.kdenlive
    audacity
  ];
}
