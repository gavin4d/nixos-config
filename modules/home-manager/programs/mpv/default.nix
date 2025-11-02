{pkgs, ...}:
{
  home.packages = with pkgs; [
    mpv
    rtorrent
    mpvScripts.webtorrent-mpv-hook
    # webtorrent_desktop
    # nodePackages.webtorrent-cli
  ];
}
