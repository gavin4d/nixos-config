{pkgs, ...}: {
  home.packages = with pkgs; [
    # fuzzel
    # wofi
    # rofi
    rofi-power-menu
    rofi-bluetooth
    # rofi-emoji
    qalculate-qt
    clipmenu
  ];
  programs.rofi = {
    # package = pkgs.wofi;
    enable = true;
    plugins = with pkgs; [
      rofi-calc
      rofi-games
    ];
    theme = "/etc/nixos/modules/home-manager/desktop/launcher/config.rasi";
  };

  xdg.desktopEntries = {
    calc = {
      name = "calc";
      genericName = "Calculator";
      exec = "rofi -show calc";
      terminal = false;
      type = "Application";
    };
    bluetooth = {
      name = "bluetooth";
      genericName = "Bluetooth";
      exec = "rofi-bluetooth ";
      terminal = false;
      type = "Application";
    };
  };
  
  home.file.".config/fuzzel/fuzzel.ini".source = ./fuzzel.ini;
  # home.file.".config/rofi/config.rasi".source = ./config.rasi;
  home.file.".config/wofi/config".source = ./config;
  home.file.".config/wofi/colors".source = ./colors;
  home.file.".config/wofi/style.css".source = ./style.css;
}
