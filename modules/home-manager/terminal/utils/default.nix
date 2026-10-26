{pkgs, ...}:
{
  home.packages = with pkgs; [
    lpac
    pcsclite
    gtkdialog
    uget
    libx11
    libqmi
    # easylpac
    can-utils
    gnumake
    rpiboot
    csvlens
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
    poppler-utils
    ocamlPackages.cpdf
    pdftk
    ghostscript # ghost script
    bc
    zip
    libimobiledevice
    # ventoy
    eza # better ls
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
