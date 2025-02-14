{pkgs, ...}:
{
  home.packages = with pkgs; [
    chirp
    sdrpp
    gnuradio
    svxlink
    rtl-sdr
    nanovna-saver
    nanovna-qt
  ];
}
