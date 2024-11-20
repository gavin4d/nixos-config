{pkgs, ...}:
{
  home.packages = with pkgs; [
    spotify
    spotify-player
    spotdl
    # cue
    # cmus
    # mp3blaster
    strawberry
  ];
}
