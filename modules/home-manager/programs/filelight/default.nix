{pkgs, ...}: {
  home.packages = with pkgs; [
    libsForQt5.filelight
  ];
}
