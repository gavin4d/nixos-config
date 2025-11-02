{config, pkgs, ...}: {

  home.packages = [
    pkgs.steam
    pkgs.legendary-gl
    pkgs.heroic
    pkgs.wine
    # steamPackages.steam-fhsenv-without-steam
    # pkgs-stable.steam-run
  ];
  # programs.steam = {
  #   enable = true;
  #   remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  #   dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  #   localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  # };
}
