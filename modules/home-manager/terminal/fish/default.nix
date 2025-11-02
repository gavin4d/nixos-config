{pkgs, ...}:
{
  #programs.fish = {
  #  enable = true;
  #};
  home.packages = with pkgs; [
    fish
    fishPlugins.tide
    asciiquarium
  ];

  home.file.".config/fish/config.fish".text = import ./fish_conf.nix;

}
