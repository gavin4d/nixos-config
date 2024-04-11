{pkgs, ...}:
{
  home.packages = with pkgs; [
    mpv
    mpvScripts.webtorrent-mpv-hook
    nodePackages.webtorrent-cli
  ];
}
