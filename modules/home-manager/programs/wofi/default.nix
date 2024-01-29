{pkgs, ...}:

{
  home.packages = with pkgs; [
    wofi,
  ];

  home.file.".config/wofi/config".text = import ./config;
  home.file.".config/wofi/colors".text = import ./colors;
  home.file.".config/wofi/style.css".text = import ./style.css;
}
