{pkgs, ...}:
{
  home.packages = with pkgs; [
    mpv
<<<<<<< HEAD
<<<<<<< HEAD
    mpvScripts.webtorrent-mpv-hook
    nodePackages.webtorrent-cli
=======
#    mpvScripts.webtorrent-mpv-hook
#    nodePackages.webtorrent-cli
>>>>>>> 68a5c45 (switched laptops)
=======
    mpvScripts.webtorrent-mpv-hook
    nodePackages.webtorrent-cli
>>>>>>> b6f316c (update)
  ];
}
