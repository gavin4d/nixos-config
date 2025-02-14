{inputs, pkgs, ...}:
{
  imports = [inputs.ags.homeManagerModules.default];
  home.packages = with pkgs; [
    sassc
    libnotify
  ];
  programs.ags = {
    enable = true;

    # null or path, leave as null if you don't want hm to manage the config
    configDir = ../ags;#/dotfiles/ags;

    # additional packages to add to gjs's runtime
    extraPackages = [
      inputs.ags.packages.${pkgs.system}.battery
      inputs.ags.packages.${pkgs.system}.hyprland
      inputs.ags.packages.${pkgs.system}.mpris
      inputs.ags.packages.${pkgs.system}.network
      inputs.ags.packages.${pkgs.system}.wireplumber
      inputs.ags.packages.${pkgs.system}.tray
      inputs.ags.packages.${pkgs.system}.notifd
      inputs.ags.packages.${pkgs.system}.powerprofiles

      pkgs.libsoup_3
    ];
  };
  
  

}
