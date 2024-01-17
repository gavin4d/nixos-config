{pkgs, ...}:
{
  home.packages = [
    pkgs.kitty
  ];

  home.file.".config/kitty/kitty.conf".text = import ./kitty_config.nix;
}
