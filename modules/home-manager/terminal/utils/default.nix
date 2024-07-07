{pkgs, ...}:
{
  home.packages = with pkgs; [
    eza
    vim
    git
    gh
    wget
    cmake
    unzip
    usbutils
    neovim
    neofetch
    gtop
    htop
    btop
    zoxide
    parted
    nix-search-cli
    sl    
    xorg.xeyes
    pulseview
    sigrok-firmware-fx2lafw
  ];
}
