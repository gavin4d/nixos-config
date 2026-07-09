{pkgs, ...}:
{
  home.packages = with pkgs; [
    spotify
    spotify-player
    spotdl
    slskd
    # cue
    # cmus
    # mp3blaster
    strawberry
  ];
}
