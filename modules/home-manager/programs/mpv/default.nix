{pkgs, ...}:
{
  home.packages = with pkgs; [
    mpv
    rtorrent
    mpvScripts.webtorrent-mpv-hook
    slskd
    fum #MPRIS controller
    kew #music player
    # webtorrent_desktop
    # nodePackages.webtorrent-cli
  ];
  home.file."~/.config/mpv/mpv.conf".text = ''
    target-colorspace-hint=no
  '';
}
