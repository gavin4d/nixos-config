{pkgs, inputs, ...}:
{
  home.packages = with pkgs; [
    tailscale
    kdePackages.dolphin
    hyprpicker
    swww
    upower
    playerctl
    acpi
    lm_sensors
    sysstat
    networkmanagerapplet
    wl-mirror
    qpwgraph
    # globalprotect-openconnect
#    catppuccin
#    catppuccin-gtk
#    catppuccin-kde
#    catppuccin-kvantum
#    catppuccin-cursors
    dconf
    qt6Packages.qt6ct
    #libsForQt5.lightly
    nwg-look
  ];

  imports = [
    inputs.catppuccin.homeManagerModules.catppuccin
  ];

 
  #catppuccin.flavour = "mocha";
  #xdg.enable = true;
  #gtk = {
  #  enable = true;
  #  catppuccin.enable = true;
  #};

  xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;

      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
        # xdg-desktop-portal-kde
        xdg-desktop-portal-gtk
      ];
  };
}
