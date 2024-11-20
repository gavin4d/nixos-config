{config, pkgs, pkgs-stable, ...}: {

  home.packages = [
    pkgs-stable.steam
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
