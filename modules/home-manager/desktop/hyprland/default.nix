{ pkgs, config, inputs, nix-colors, lib, ... }:

{
  imports = [
    nix-colors.homeManagerModules.default
  ];

  colorScheme = nix-colors.lib.schemeFromYAML "wall-color" (builtins.readFile  ../wallpapers/colors/color.yaml);

  home.packages = with pkgs; [
    grim
    slurp
    brightnessctl
    wl-clipboard
  ];

  gtk = {
    enable = true;
    font.name = "TeX Gyre Adventor 10";
    theme = {
      name = "Nordic-darker";
      package = pkgs.nordic;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    gtk3.extraConfig = {
    Settings = ''
      gtk-application-prefer-dark-theme=1
    '';
    };

    gtk4.extraConfig = {
    Settings = ''
      gtk-application-prefer-dark-theme=1
    '';
    };
  
  };
  programs = {
    bash = {
      initExtra = ''
        if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
           exec  Hyprland
        fi
      '';
    };
    fish = {
      loginShellInit = ''
        set TTY1 (tty)
        [ "$TTY1" = "/dev/tty1" ] && exec Hyprland
      '';
    };
  };
  systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;

    xwayland.enable = true;

    systemd.enable = true;

    settings = {
          
      monitor=
        [
          "eDP-1,1920x1200,auto,1"
          "HDMI-A-1,preferred,auto,1"
          ",preferred,auto,1"
        ];

      env = [
        "HYPRCURSOR_THEME,phinger-cursors-dark"
        "HYPRCURSOR_SIZE,24"
        "XCURSOR,phinger-cursors-dark"
        "XCURSOR_SIZE,24"
        "QT_QPA_PLATFORMTHEME,qt5ct"
      ];

#####################################################################################
##################################    Bindings    ###################################
#####################################################################################
      
      "$mainMod" = "SUPER";
      "$shiftKey" = "SHIFT";
      "$alttKey" = "ALT";

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm =
        [
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];

      bind =
        [
          ", $mainMod, workspace, 4"
          
          # shortcuts
          "$mainMod, R, exec, wofi --show drun"

          # window controls
          "$mainMod, Q, killactive"
          "$mainMod $shiftKey, Q, exec, hyprctl activewindow |grep pid |tr -d 'pid:'|xargs kill"
          "$mainMod , F, fullscreen"
          "$mainMod, space, togglefloating"
          "$mainMod, S, togglesplit" # dwindle
          "$mainMod $shiftKey, A, pin" # Keep above
          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"
          "$mainMod, h, movefocus, l"
          "$mainMod, l, movefocus, r"
          "$mainMod, k, movefocus, u"
          "$mainMod, j, movefocus, d"
          "$mainMod SHIFT, left, movewindow, l"
          "$mainMod SHIFT, right, movewindow, r"
          "$mainMod SHIFT, up, movewindow, u"
          "$mainMod SHIFT, down, movewindow, d"
          "$mainMod SHIFT, h, movewindow, l"
          "$mainMod SHIFT, l, movewindow, r"
          "$mainMod SHIFT, k, movewindow, u"
          "$mainMod SHIFT, j, movewindow, d"
          "$mainMod $alttKey, left, splitratio, -0.05"
          "$mainMod $alttKey, right, splitratio, 0.05"
          "$mainMod, mouse_down, workspace, e+1"
          "$mainMod, mouse_up, workspace, e-1"
          "$mainMod, Escape, workspace, previous"

          ", xf86Display, movecurrentworkspacetomonitor, +1"

          # volume controls
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
          # applications
          "$mainMod, return, exec, kitty"
          ",Print, exec, grim -g \"$(slurp -d -c 00000000 -b 00aaaa22)\" - | wl-copy -t image/png"
          "$shiftKey, Print, exec, hyprpicker | wl-copy"

          ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
          builtins.concatLists (builtins.genList (
              x: let
                ws = let
                  c = (x + 1) / 10;
                in
                  builtins.toString (x + 1 - (c * 10));
              in [
                "$mainMod, ${ws}, workspace, ${toString (x + 1)}"
                "$mainMod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              ]
            )
            10)
        );
      binde =
        [
          # volume controls
          ", xf86audioraisevolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
          ", xf86audiolowervolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- "
          "$mainMod, xf86audioraisevolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
          "$mainMod, xf86audiolowervolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- "

          # brightness controls
          ", xf86monbrightnessup, exec, brightnessctl set 5%+"
          ", xf86monbrightnessdown, exec, brightnessctl set 5%-"
        ];
      bindi =
        [
          "$mainMod, Super_L, exec, ags request -i main-ags 'show bar'"
        ];
      bindrt =
        [
          "$mainMod, Super_L, exec, ags request -i main-ags 'hide bar'"
        ];
      

#####################################################################################
##################################    Variables    ##################################
#####################################################################################

      input = {
        kb_layout = "us";
        kb_options = "grp:alt_shift_toggle";
        follow_mouse = 1;
        touchpad.natural_scroll = false;
        sensitivity = 0;
      };

      general = {
        gaps_in = 4;
        gaps_out = 6;
        border_size = 2;
        # "col.active_border" = "rgba(a34b25FF)";
        "col.active_border" = "rgb(${config.colorScheme.palette.base0E}) rgb(${config.colorScheme.palette.base0F}) 45deg";
        "col.inactive_border" = "rgb(${config.colorScheme.palette.base00})";
        layout = "dwindle";
      };

      
      decoration = {
          
          active_opacity = 1.0;
          inactive_opacity = 1.0;
          fullscreen_opacity = 1.0;
          # Blur rules
          rounding = 8;
      
          blur = {
              enabled = true;
              size = 3;
              passes = 2;
              noise = 0.05;
              new_optimizations = true;
              brightness = 0.4;
              ignore_opacity = true;
              xray = false;
              popups = true;
              popups_ignorealpha = 1;
          };
      
          # blur_xray = false
          # Shadow
          # drop_shadow = true;
          # shadow_range = 30;
          # shadow_render_power = 3;
          # "col.shadow" = "rgba(01010144)";
          
          # Dim
          dim_inactive = false;
          dim_strength = 0.1;
          dim_special = 0;
      };

      # windowrule = [
      #   "opacity 0.999,^(firefox)$"
      # ];
      
      
      animations = {
          enabled = true;
      
          # Animation curves
          bezier = 
            [
              "md3_standard, 0.2, 0.0, 0, 1.0"
              "md3_decel, 0.05, 0.7, 0.1, 1"
              "md3_accel, 0.3, 0, 0.8, 0.15"
              "overshoot, 0.05, 0.9, 0.1, 1.05"
              "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
              "bounce, 0.4, 0.05, 0, 1.1"
              "test, 2, 1.25, -0.5, -1"
              "funky, 0.46, 0.35, -0.2, 1.2"
            ];
          # Animation configs
          animation = 
            [
              "windows, 1, 2, overshoot, slide"
              "border, 1, 1, default"
              "workspaces, 1, 2, overshoot, slide"
              "fadeIn, 1, 5, md3_decel"
              "fadeOut, 1, 5, md3_decel"
              "layers, 1, 0.2, default"
            ];
      
      };
      
      dwindle = {
          # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
          pseudotile = true;
          preserve_split = true;
          # special_scale_factor = 1;
          # permanent_direction_override = true;
          # split_width_multiplier = 1;
          # force_split = 1;
          # preserve_split = true;
          # smart_resizing = false;
      };
      
      master = {
          # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
          allow_small_split = true;
          special_scale_factor = 1;
          mfact = 0.5;
          new_on_top = false;
          # orientation = "right";
          # always_center_master = true;
      };
      
      gestures = {
          workspace_swipe = true;
          workspace_swipe_invert = false;
          # workspace_swipe_distance = 100;
          workspace_swipe_cancel_ratio = 0.1;
          # workspace_swipe_numbered = true;
          workspace_swipe_create_new = false;
      };
      
      misc = {
          disable_hyprland_logo = true;
      };

#####################################################################################
##################################    Start up    ###################################
#####################################################################################

      exec-once = 
        [
          "swww-daemon"
          "nm-applet -sm-disable"
          "blueman-applet"
          "killall xfce4-notifyd"
          "ags run /etc/nixos/modules/home-manager/desktop/ags/app.ts"
          "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
          "swww init"
          # "swww img -t grow --transition-duration 1.5 /etc/nixos/modules/home-manager/desktop/wallpapers/13.jpg"
          "/etc/nixos/modules/home-manager/desktop/wallpapers/change-wallpaper.sh 13"
          "nix-shell ~/programming/Music-Player/shell.nix"
        ];

    };
  };
}
