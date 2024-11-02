{pkgs, inputs, ...}:
{
  home.packages = with pkgs; [
    hyprpicker
    swww
    upower
    playerctl
    acpi
    lm_sensors
    sysstat
    networkmanagerapplet
    # globalprotect-openconnect
#    catppuccin
#    catppuccin-gtk
#    catppuccin-kde
#    catppuccin-kvantum
#    catppuccin-cursors
    dconf
    qt6ct
    #libsForQt5.lightly
    lightly-qt
    nwg-look
  ];

  imports = [inputs.catppuccin.homeManagerModules.catppuccin];
  
  #catppuccin.flavour = "mocha";
  #xdg.enable = true;
  #gtk = {
  #  enable = true;
  #  catppuccin.enable = true;
  #};
}
