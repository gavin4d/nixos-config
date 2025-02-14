{pkgs, ...}: {
  home.packages = with pkgs; [
    remmina
    gpauth
    gpclient
    openconnect
    networkmanager-openconnect
    glib-networking
  ];
}
