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
    killall
    jq
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
           exec  start-hyprland
        fi
      '';
    };
    fish = {
      loginShellInit = ''
        set TTY1 (tty)
        [ "$TTY1" = "/dev/tty1" ] && exec start-hyprland
      '';
    };
  };
  systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;

    xwayland.enable = true;

    systemd.enable = true;

  # home.file."~/.config/hypr/hyprland.conf".text = ''

  #   exec-once = /nix/store/5gln2rkcjx93cr5x0rr3wqrxjdmshd2f-dbus-1.16.2/bin/dbus-update-activation-environment --systemd DISPLAY HYPRLAND_INSTANCE_SIGNATURE WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE && systemctl --user stop hyprland-session.target && systemctl --user start hyprland-session.target
  #   $alttKey=ALT
  #   $mainMod=SUPER
  #   $shiftKey=SHIFT
  #   animations {
  #     bezier=md3_standard, 0.2, 0.0, 0, 1.0
  #     bezier=md3_decel, 0.05, 0.7, 0.1, 1
  #     bezier=md3_accel, 0.3, 0, 0.8, 0.15
  #     bezier=overshoot, 0.05, 0.9, 0.1, 1.05
  #     bezier=hyprnostretch, 0.05, 0.9, 0.1, 1.0
  #     bezier=bounce, 0.4, 0.05, 0, 1.1
  #     bezier=test, 2, 1.25, -0.5, -1
  #     bezier=funky, 0.46, 0.35, -0.2, 1.2
  #     bezier=ease-out-binbos, 0, 1, 0.5, 1
  #     animation=windows, 1, 3, ease-out-binbos, popin
  #     animation=border, 1, 2, default
  #     animation=workspaces, 1, 3, ease-out-binbos, slide
  #     animation=fadeIn, 1, 3, default
  #     animation=fadeOut, 1, 3, default
  #     animation=layers, 1, 0.2, default
  #     enabled=true
  #   }

  #   bind=$mainMod, R, exec, killall rofi || rofi -show drun
  #   bind=$mainMod, Q, killactive
  #   bind=$mainMod $shiftKey, Q, exec, hyprctl activewindow |grep pid |tr -d 'pid:'|xargs kill
  #   bind=$mainMod , F, fullscreen
  #   bind=$mainMod, space, togglefloating
  #   bind=$mainMod, S, togglesplit
  #   bind=$mainMod $shiftKey, A, pin
  #   bind=$mainMod, left, movefocus, l
  #   bind=$mainMod, right, movefocus, r
  #   bind=$mainMod, up, movefocus, u
  #   bind=$mainMod, down, movefocus, d
  #   bind=$mainMod, h, movefocus, l
  #   bind=$mainMod, l, movefocus, r
  #   bind=$mainMod, k, movefocus, u
  #   bind=$mainMod, j, movefocus, d
  #   bind=$mainMod SHIFT, left, movewindow, l
  #   bind=$mainMod SHIFT, right, movewindow, r
  #   bind=$mainMod SHIFT, up, movewindow, u
  #   bind=$mainMod SHIFT, down, movewindow, d
  #   bind=$mainMod SHIFT, h, movewindow, l
  #   bind=$mainMod SHIFT, l, movewindow, r
  #   bind=$mainMod SHIFT, k, movewindow, u
  #   bind=$mainMod SHIFT, j, movewindow, d
  #   bind=$mainMod $alttKey, left, splitratio, -0.05
  #   bind=$mainMod $alttKey, right, splitratio, 0.05
  #   bind=$mainMod, mouse_down, workspace, e+1
  #   bind=$mainMod, mouse_up, workspace, e-1
  #   bind=$mainMod, Escape, workspace, previous
  #   bind=$mainMod, tab, togglespecialworkspace
  #   bind=, xf86Display, movecurrentworkspacetomonitor, +1
  #   bind=SHIFT, xf86monbrightnessup, exec, brightnessctl set 100%
  #   bind=SHIFT, xf86monbrightnessdown, exec, brightnessctl set 1
  #   bind=, XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
  #   bind=, XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
  #   bind=$mainMod, return, exec, kitty
  #   bind=,Print, exec, grim -g "$(slurp -d -c 00000000 -b 00aaaa22)" - | wl-copy -t image/png
  #   bind=$shiftKey, Print, exec, hyprpicker | wl-copy
  #   bind=$mainMod, 1, workspace, 1
  #   bind=$mainMod SHIFT, 1, movetoworkspace, 1
  #   bind=$mainMod, 2, workspace, 2
  #   bind=$mainMod SHIFT, 2, movetoworkspace, 2
  #   bind=$mainMod, 3, workspace, 3
  #   bind=$mainMod SHIFT, 3, movetoworkspace, 3
  #   bind=$mainMod, 4, workspace, 4
  #   bind=$mainMod SHIFT, 4, movetoworkspace, 4
  #   bind=$mainMod, 5, workspace, 5
  #   bind=$mainMod SHIFT, 5, movetoworkspace, 5
  #   bind=$mainMod, 6, workspace, 6
  #   bind=$mainMod SHIFT, 6, movetoworkspace, 6
  #   bind=$mainMod, 7, workspace, 7
  #   bind=$mainMod SHIFT, 7, movetoworkspace, 7
  #   bind=$mainMod, 8, workspace, 8
  #   bind=$mainMod SHIFT, 8, movetoworkspace, 8
  #   bind=$mainMod, 9, workspace, 9
  #   bind=$mainMod SHIFT, 9, movetoworkspace, 9
  #   bind=$mainMod, 0, workspace, 10
  #   bind=$mainMod SHIFT, 0, movetoworkspace, 10

  #   binde=, xf86audioraisevolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
  #   binde=, xf86audiolowervolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- 
  #   binde=$mainMod, xf86audioraisevolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
  #   binde=$mainMod, xf86audiolowervolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- 
  #   binde=, xf86audioplay, exec, playerctl play-pause
  #   binde=, xf86audionext, exec, playerctl next
  #   binde=, xf86audioprev, exec, xeyes
  #   binde=, xf86monbrightnessup, exec, brightnessctl set 5%+
  #   binde=, xf86monbrightnessdown, exec, brightnessctl set 5%-
  #   binde=$mainMod, xf86monbrightnessup, exec, brightnessctl set 5%+
  #   binde=$mainMod, xf86monbrightnessdown, exec, brightnessctl set 5%-

  #   bindi=$mainMod, Super_L, exec, ags request -i main-ags 'show bar'

  #   bindm=$mainMod, mouse:272, movewindow
  #   bindm=$mainMod, mouse:273, resizewindow

  #   bindrt=$mainMod, Super_L, exec, ags request -i main-ags 'hide bar'

  #   decoration {
  #     blur {
  #       brightness=0.400000
  #       enabled=true
  #       ignore_opacity=true
  #       new_optimizations=true
  #       noise=0.050000
  #       passes=2
  #       popups=true
  #       popups_ignorealpha=1
  #       size=3
  #       xray=false
  #     }
  #     active_opacity=1.000000
  #     dim_inactive=true
  #     dim_special=0
  #     dim_strength=0.100000
  #     fullscreen_opacity=1.000000
  #     inactive_opacity=1.000000
  #     rounding=8
  #   }

  #   dwindle {
  #     preserve_split=true
  #     pseudotile=true
  #   }

  #   env=HYPRCURSOR_THEME,phinger-cursors-dark
  #   env=HYPRCURSOR_SIZE,24
  #   env=XCURSOR,phinger-cursors-dark
  #   env=XCURSOR_SIZE,24
  #   env=QT_QPA_PLATFORMTHEME,qt5ct

  #   exec-once=awww-daemon
  #   exec-once=nm-applet -sm-disable
  #   exec-once=blueman-applet
  #   exec-once=killall xfce4-notifyd
  #   exec-once=dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
  #   exec-once=/etc/nixos/modules/home-manager/desktop/wallpapers/change-wallpaper.sh 11
  #   exec-once=nix-shell ~/programming/Music-Player/shell.nix

  #   general {
  #     border_size=0
  #     col.active_border=rgba(000000FF)
  #     col.inactive_border=rgba(00000000)
  #     gaps_in=4
  #     gaps_out=6
  #     layout=dwindle
  #   }

  #   gesture=3, horizontal, workspace
  #   gesture=4, down, close
  #   gesture=4, up, dispatcher, exec, killall rofi || rofi -show drun

  #   gestures {
  #     workspace_swipe_create_new=false
  #     workspace_swipe_distance=100
  #     workspace_swipe_invert=false
  #   }

  #   input {
  #     kb_options=grp:alt_shift_toggle
  #     kb_options=ctrl:nocaps

  #     touchpad {
  #       natural_scroll=false
  #     }
  #     follow_mouse=1
  #     kb_layout=us
  #     sensitivity=0
  #   }

  #   master {
  #     allow_small_split=true
  #     mfact=0.500000
  #     new_on_top=false
  #     special_scale_factor=1
  #   }

  #   misc {
  #     disable_hyprland_logo=true
  #   }

  #   monitor=eDP-1,1920x1200,auto,1
  #   monitor=HDMI-A-1,preferred,auto,1
  #   monitor=,preferred,auto,1

  #   windowrule {
  #     name = edge-bs
  #     match:class = ^$
  #     match:title = ^$
  
  #     float = on
  #     no_initial_focus = on
  #   }

  #   windowrule {
  #     name = pip-float
  #     match:title = .*Picture-in-Picture.*

  #     float = on
  #     pin = on
  #     move = (monitor_w-400) (monitor_h-300)
  #     size = 400 225
  #   }
  # '';
# }

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
         
          # shortcuts
          "$mainMod, R, exec, killall rofi || rofi -show drun"

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
          "$mainMod, tab, togglespecialworkspace"

          ", xf86Display, movecurrentworkspacetomonitor, +1"

          "SHIFT, xf86monbrightnessup, exec, brightnessctl set 100%"
          "SHIFT, xf86monbrightnessdown, exec, brightnessctl set 1"

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

          ", xf86audioplay, exec, playerctl play-pause"
          ", xf86audionext, exec, playerctl next"
          ", xf86audioprev, exec, xeyes"

          # brightness controls
          ", xf86monbrightnessup, exec, brightnessctl set 5%+"
          ", xf86monbrightnessdown, exec, brightnessctl set 5%-"
          "$mainMod, xf86monbrightnessup, exec, brightnessctl set 5%+"
          "$mainMod, xf86monbrightnessdown, exec, brightnessctl set 5%-"
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
        kb_options = ["grp:alt_shift_toggle" "ctrl:nocaps"];
        follow_mouse = 1;
        touchpad.natural_scroll = false;
        sensitivity = 0;
      };

      general = {
        gaps_in = 4;
        gaps_out = 6;
        border_size = 0;
        # "col.active_border" = "rgba(a34b25FF)";
        "col.active_border" = "rgba(000000FF)";
        # "col.active_border" = "rgb(${config.colorScheme.palette.base0E}) rgb(${config.colorScheme.palette.base0F}) 45deg";
        # "col.inactive_border" = "rgb(${config.colorScheme.palette.base00})";
        "col.inactive_border" = "rgba(00000000)";
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
          dim_inactive = true;
          dim_strength = 0.1;
          dim_special = 0;
      };

      windowrule = [
        # "opacity 0.999,^(firefox)$"
        # "noblur, class:Rofi"
        "float on, match:class ^$" # fix microsoft-edge title attributes showing as windows
        "float on, pin on, move (monitor_w-400) (monitor_h-225), size 400 225, match:title ^Picture in picture$"
        # "pin on, match:title = Picture in picture"
  #     float = on
  #     pin = on
  #     
  #     size = 400 225
  #   }

      ];
      
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
              "ease-out-binbos, 0, 1, 0.5, 1"
            ];
          # Animation configs
          animation = 
            [
              "windows, 1, 3, ease-out-binbos, popin"
              "border, 1, 2, default"
              "workspaces, 1, 3, ease-out-binbos, slide"
              "fadeIn, 1, 3, default"
              "fadeOut, 1, 3, default"
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
      
      gesture = [
        "3, horizontal, workspace"
        "4, down, close"
        "4, up, dispatcher, exec, killall rofi || rofi -show drun"
      ];

      gestures = {
          workspace_swipe_create_new = false;
          workspace_swipe_distance = 100;
          workspace_swipe_invert = false;
      };
      
      misc = {
          disable_hyprland_logo = true;
      };

#####################################################################################
##################################    Start up    ###################################
#####################################################################################

      exec-once = 
        [
          "awww-daemon"
          "nm-applet -sm-disable"
          "blueman-applet"
          "killall xfce4-notifyd"
          # "ags run /etc/nixos/modules/home-manager/desktop/ags/app.ts"
          "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
          # "swww img -t grow --transition-duration 1.5 /etc/nixos/modules/home-manager/desktop/wallpapers/13.jpg"
          "/etc/nixos/modules/home-manager/desktop/wallpapers/change-wallpaper.sh 11"
          "nix-shell ~/programming/Music-Player/shell.nix"
        ];

    };
  };
}