{pkgs, ...}:

{
  home.packages = with pkgs; [
    wofi
  ];
  # programs.rofi = {
  #   package = pkgs.wofi;
  #   enable = true;
  #   plugins = with pkgs; [
  #     rofi-calc
  #   ];
  # };

  home.file.".config/wofi/config".source = ./config;
  home.file.".config/wofi/colors".source = ./colors;
  home.file.".config/wofi/style.css".source = ./style.css;
}
