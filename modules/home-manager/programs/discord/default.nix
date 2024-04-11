{ config, pkgs, ... }:
{
  programs.firefox = { 
    profiles.discord = {
      id = 1; # change if you already have a second profile
      isDefault = false;
      settings = {
        "browser.startup.homepage" = "https://discord.com/channels/@me";
      };
      userChrome = ''
        #navigator-toolbox {
          transition: 0.2s margin-top ease-out 10ms !important;
        }

        /* Collapse tab bar when there is only one tab (first visible tab is adjacent to new tab button) */
        #main-window:not([customizing]) #navigator-toolbox:has(tab:first-child[selected="true"] + #tabbrowser-arrowscrollbox-periphery):not(:hover):not(:focus-within) {
          margin-top: -90px !important;
        }
      ''; 
    };
  };

  home.file.".local/share/applications/discord.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Version=1.0
    Name=Discord
    Icon=discord
    Exec=firefox -P discord
  '';
}
