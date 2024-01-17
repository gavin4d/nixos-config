{pkgs, ...}:
{
  #programs.fish = {
  #  enable = true;
  #};
  home.packages = [
    pkgs.fish
  ];

  home.file.".config/fish/config.fish".text = import ./fish_conf.nix;

}
