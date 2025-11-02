{pkgs, ...}:
{
  home.packages = with pkgs; [
    arduino
    gcc-arm-embedded
    stm32cubemx
    minicom
    putty
  ];
}
