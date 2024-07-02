{pkgs, ...}:
{
  home.packages = with pkgs; [
    kicad
  ];
#  programs.kicad = {
#    enable = true;
#    catppuccin = {
#      flavour = "Latte";
#      enable = true;
#    };
#  };
}
