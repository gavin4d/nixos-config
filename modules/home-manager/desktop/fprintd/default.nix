{pkgs, inputs, ...}:
{
  home.packages = with pkgs; [
    fprintd
  ];
}
