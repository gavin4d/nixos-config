{ config, pkgs, ... }:
let 

      inv-query = pkgs.writeScriptBin "inv-query"  ''
          #!${pkgs.zsh}/bin/zsh

          ([[ $1 = "-r" ]] && (${pkgs.curl}/bin/curl -H "Authorization: Token inv-cfc33c0a65ddc3bb3ed62ac4f7e3b6231fab5e2b-20250827" "https://inventree.goatfastracing.com/api/part/" | ${pkgs.jq}/bin/jq -r '.[] | select(.IPN != "") | .IPN + "   " + .name' > ~/.cache/fsae/inv-new.txt) && mv ~/.cache/fsae/inv-new.txt ~/.cache/fsae/inv.txt && notify-send "Inventory Updated")& 

          IPN=$(cat ~/.cache/fsae/inv.txt | rofi -dmenu -i -matching-negate-char '\0' | sed 's/ .*//')
          
          [[ ! -z "$IPN" ]] && firefox https://inventree.goatfastracing.com/part/$IPN/
      '';

      ki-open = pkgs.writeScriptBin "ki-open"  ''
          #!${pkgs.zsh}/bin/zsh

          PROJECT=$(tree ~/projects -fi -L 5 | grep .kicad_pro | sed 's/\.\///' | rofi -dmenu -i -matching-negate-char '\0')

          [[ ! -z "$PROJECT" ]] && kicad $PROJECT

      '';

in {
  home.packages = [
    inv-query
    ki-open
  ];

  xdg.desktopEntries = {
    inv-query = {
      name = "inv-query";
      genericName = "Rofi Selector";
      exec = "inv-query";
      terminal = false;
      type = "Application";
    };
    ki-open = {
      name = "ki-open";
      genericName = "Rofi Selector";
      exec = "ki-open";
      terminal = false;
      type = "Application";
    };
  }; 
}