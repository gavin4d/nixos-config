 config, pkgs, ... }:
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
        "browser.startup.homepage" = "file://${./homepage.html}";
      };
      userChrome = ''
        /*=============== FIREFOX ===============*

        #TabsToolbar{ 
          display: none !important;
        }
        
        /* hide navigation bar when it is not focused; use Ctrl+L to get focus */
        #main-window:not([customizing]) #navigator-toolbox:not(:focus-within):not(:hover) {
          margin-top: -45px;
        }
        #navigator-toolbox {
          transition: 0.2s margin-top ease-out;
        }
        
        #PersonalToolbar{
          --uc-bm-height: 20px; /* Might need to adjust if the toolbar has other buttons */
          --uc-bm-padding: 4px; /* Vertical padding to be applied to bookmarks */
          --uc-autohide-toolbar-delay: 250ms; /* The toolbar is hidden after 0.25s */
        }
        
        #PersonalToolbar:not([customizing]){
          position: relative;
          margin-bottom: calc(0px - var(--uc-bm-height) - 2 * var(--uc-bm-padding));
          transform: scaleY(0);
          transform-origin: top;
          transition: transform 100ms ease var(--uc-autohide-toolbar-delay) !important;
          z-index: 1;
        }
        
        #nav-bar:focus-within + #PersonalToolbar, #navigator-toolbox:hover #PersonalToolbar{
          transition-delay: 100ms !important;
          transform: scaleY(1);
        }

        /*=============== TREE TABS ==============*/

        :root {
          --thin-tab-width: 40px;
          --wide-tab-width: 200px;
        }
        
        #sidebar-box[sidebarcommand="treestyletab_piro_sakura_ne_jp-sidebar-action"] {
          /*position: relative !important;*/
          transition: all 100ms ease 250ms !important; /*hover delay for avoiding accidental expansion on mouse hover*/
          min-width: var(--thin-tab-width) !important;
          max-width: var(--thin-tab-width) !important;
          margin-top: 0px !important;
          z-index: 2;
        }
        
        #sidebar-box[sidebarcommand="treestyletab_piro_sakura_ne_jp-sidebar-action"]:hover {
          width: var(--wide-tab-width) !important;
          max-width: var(--wide-tab-width) !important;
          margin-right: calc((var(--wide-tab-width) - var(--thin-tab-width)) * -1) !important;
        }
        
        /* Remove the side bar header */
        #sidebar-box[sidebarcommand="treestyletab_piro_sakura_ne_jp-sidebar-action"] #sidebar-header {
          display: none !important;
        }
        
        /* Remove the line between the side bar and main content */
        #sidebar-box[sidebarcommand="treestyletab_piro_sakura_ne_jp-sidebar-action"] + #sidebar-splitter {
          display: none !important;
        }
        
        #PersonalToolbar{ 
          margin-left: var(--thin-tab-width);
        }

      ''; 
    };
  };
}
