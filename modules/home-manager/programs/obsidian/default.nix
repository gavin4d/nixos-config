{pkgs, lib, ...}:
{
  nixpkgs.overlays = [
    (final: prev: {
      obsidian-wayland = prev.obsidian.override {electron = final.electron_24;};
    })
  ];
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = pkgs.lib.optional (pkgs.obsidian.version == "1.5.3") "electron-24.8.6"; #25.9.0
  };
  home.packages = with pkgs; [
    obsidian-wayland
  ];
}
