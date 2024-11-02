{pkgs, ...}:
{
  home.packages = with pkgs; [
    mpv
    rtorrent
    # mpvScripts.webtorrent-mpv-hook
    # nodePackages.webtorrent-cli
  ];
}
