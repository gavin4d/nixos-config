{pkgs, ...}:

{
  home.packages = with pkgs; [
    wofi
  ];

  home.file.".config/wofi/config".source = ./config;
  home.file.".config/wofi/colors".source = ./colors;
  home.file.".config/wofi/style.css".source = ./style.css;
}
