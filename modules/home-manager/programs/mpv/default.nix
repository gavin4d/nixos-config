{pkgs, ...}:
{
  home.packages = with pkgs; [
    mpv
<<<<<<< HEAD
    mpvScripts.webtorrent-mpv-hook
    nodePackages.webtorrent-cli
=======
#    mpvScripts.webtorrent-mpv-hook
#    nodePackages.webtorrent-cli
>>>>>>> 68a5c45 (switched laptops)
  ];
}
