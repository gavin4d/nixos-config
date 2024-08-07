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
    extraPackages = [ pkgs.libsoup_3 ];
  };
  
  

}
