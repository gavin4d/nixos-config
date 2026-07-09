{config, pkgs, ...}:
{

  home.packages = with pkgs; [
    steam
    retroarch
    legendary-gl
    heroic
    # steamPackages.steam-fhsenv-without-steam
    # pkgs-stable.steam-run
    # wineWowPackages.waylandFull
    # freetype
    # winepkg.wine64
  ];
  # programs.steam = {
  #   enable = true;
  #   remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  #   dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  #   localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  # };
}
