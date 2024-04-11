{pkgs, ...}:
{
  home.packages = with pkgs; [
    icestorm
    yosys
  ];
}
