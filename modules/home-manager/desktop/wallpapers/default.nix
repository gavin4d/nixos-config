{ config, pkgs, ... }:
let 

      set-wall = pkgs.writeScriptBin "set-wall"  ./rofi-wall-select.sh;

in {
  home.packages = [
    set-wall
  ];

  xdg.desktopEntries = {
    set-wall = {
      name = "Wallpaper";
      genericName = "Wallpaper Selector";
      exec = "set-wall";
      terminal = false;
      type = "Application";
    };
  }; 
}
