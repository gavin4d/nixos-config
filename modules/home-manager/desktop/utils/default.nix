{pkgs, ...}:
{
  home.packages = with pkgs; [
    swww
    upower
    playerctl
    acpi
    lm_sensors
    sysstat
    networkmanagerapplet
  ];
}
