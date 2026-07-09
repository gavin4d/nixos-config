{pkgs, ...}:
{
  home.packages = with pkgs; [
    arduino
    gcc-arm-embedded
    stm32cubemx
    minicom
    putty
    nrfutil
    nrfconnect
    openocd
  ];
   nixpkgs.config.allowUnfree = true;
   nixpkgs.config.segger-jlink.acceptLicense = true;
}
