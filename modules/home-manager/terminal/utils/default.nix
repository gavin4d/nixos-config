{pkgs, ...}:
{
  home.packages = with pkgs; [
    git
    wget
    unzip
    usbutils
    neovim
  ];
}
