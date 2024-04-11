{pkgs, ...}:
{
  home.packages = with pkgs; [
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
    zoxide
    nix-search-cli
  ];
}
