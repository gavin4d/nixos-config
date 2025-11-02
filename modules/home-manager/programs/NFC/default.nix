{pkgs, ...}:
{
  home.packages = with pkgs; [
    pcsc-tools
    # pcsclite
    # libacr38u
    # scmccid
    libnfc
    # acsccid
    # ccid
  ];
}
