{pkgs, ...}:

{
  home.packages = with pkgs; [
    wofi
    rofi
  ];
  # programs.rofi = {
  #   # package = pkgs.wofi;
  #   enable = true;
  #   plugins = with pkgs; [
  #     rofi-calc
  #   ];
  #   extraConfig = builtins.readFile ./config.rasi;
  # };

  home.file.".config/rofi/config.rasi".source = ./config.rasi;
  home.file.".config/wofi/config".source = ./config;
  home.file.".config/wofi/colors".source = ./colors;
  home.file.".config/wofi/style.css".source = ./style.css;
}
