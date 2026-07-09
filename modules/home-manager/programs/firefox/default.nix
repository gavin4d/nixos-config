{ config, pkgs, ... }:
# let
#   pkgsOld = import (pkgs.fetchFromGitHub {
#     owner = "NixOS";
#     repo = "nixpkgs";
#     rev = "f09dede81861f3a83f7f06641ead34f02f37597f";
#     sha256 = "92vihpZr6dwEMV6g98M5kHZIttrWahb9iRPBm1atcPk=";
#     }) {
#       inherit (pkgs) system;
#     };
# in
{
  programs.firefox = {
    enable = true;
    package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
      extraPolicies = {
        DisplayBookmarksToolbar = true;
        Preferences = {
          "browser.toolbars.bookmarks.visibility" = "never";
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "media.ffmpeg.vaapi.enabled" = true;
        };
      };
    };
    profiles.default = {
      settings = {
        #"browser.startup.homepage" = "file://${./homepage.html}";
      };
      # userChrome = builtins.readFile(./userChrome.css);
    };
  };
  nixpkgs.config.allowUnfreePredicate = _: true;
  home.packages = with pkgs; [
    readability-cli
    ffsend
    # floorp
    # pkgsOld.microsoft-edge
    microsoft-edge
  ];
}
