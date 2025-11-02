{pkgs, ...}:
{
  home.packages = with pkgs; [
    inetutils
    nmap
    cmatrix
    checkra1n
    iperf
    chromium
    vscode
    qtcreator
    onedrive
    qrencode
    http-server
    onedrivegui
    poppler_utils
    zip
    libimobiledevice
    # ventoy
    eza
    asuka
    lagrange
    amfora
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
    platformio
    jmtpfs
    nix-search-cli
    sl    
    xorg.xeyes
    pulseview
    cowsay
    sigrok-firmware-fx2lafw
    ffmpeg
    rig
    espeak
    oneko
    sshfs
  ];
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    config = {
      hide_env_diff = true;
    };
  };
}
