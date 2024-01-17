{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    grim
    slurp
    brightnessctl
    wl-clipboard
  ];


  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;

    xwayland.enable = true;

    systemd.enable = true;
    enableNvidiaPatches = false;

    settings = {
          
      monitor=
        [
          "eDP-1,1920x1080,auto,1"
          "HDMI-A-1,preferred,auto,1"
          ",preferred,auto,1"
        ];

      env = "XCURSOR_SIZE,24";

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
          "$mainMod $shiftKey, Q, exit"
          
          # shortcuts
          "$mainMod, R, exec, wofi --show drun"

          # window controls
          "$mainMod, Q, killactive"
          "$mainMod , F, fullscreen"
          "$mainMod, space, togglefloating"
          "$mainMod, J, togglesplit" # dwindle
          "$alttKey $shiftKey, A, pin" # Keep above
          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"
          "$mainMod SHIFT, left, movewindow, l"
          "$mainMod SHIFT, right, movewindow, r"
          "$mainMod SHIFT, up, movewindow, u"
          "$mainMod SHIFT, down, movewindow, d"
          "$mainMod $alttKey, left, splitratio, -0.05"
          "$mainMod $alttKey, right, splitratio, 0.05"
          "$mainMod, mouse_down, workspace, e+1"
          "$mainMod, mouse_up, workspace, e-1"
          "$mainMod, Escape, workspace, previous"
          "$mainMod, H, togglespecialworkspace"

          # volume controls
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
          ", xf86audioraisevolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
          ", xf86audiolowervolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- "

          # brightness controls
          ", xf86monbrightnessup, exec, brightnessctl set 5%+"
          ", xf86monbrightnessdown, exec, brightnessctl set 5%-"
          # applications
          "$mainMod, return, exec, kitty"
          ",Print, exec, grim -g \"$(slurp)\" - | wl-copy -t image/png"

          # menus
          "$mainMod, f1, exec, ags -r \"showLeftMenu()\""
          "$mainMod, f2, exec, ags -r \"showNotificationCenter()\""
          "$mainMod, f3, exec, ags -r \"showHardwareMenu()\""
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
        "col.active_border" = "rgba(4ab0f0FF)";
        "col.inactive_border" = "rgba(59595900)";
        layout = "dwindle";
      };

      
      decoration = {
          # Blur rules
          rounding = 13;
      
          blur = {
              enabled = true;
              size = 1;
              passes = 3;
              noise = 0.0117;
              new_optimizations = true;
              brightness = 1.0;
              ignore_opacity = false;
              xray = false;
          };
      
          # blur_xray = false
          # Shadow
          drop_shadow = true;
          shadow_range = 30;
          shadow_render_power = 3;
          "col.shadow" = "rgba(01010144)";
          
          # Dim
          dim_inactive = false;
          dim_strength = 0.1;
          dim_special = 0;
      };
      
      
      animations = {
          enabled = true;
      
          # Animation curves
          bezier = 
            [
              "md3_standard, 0.2, 0.0, 0, 1.0"
              "md3_decel, 0.05, 0.7, 0.1, 1"
              "md3_accel, 0.3, 0, 0.8, 0.15"
              "overshot, 0.05, 0.9, 0.1, 1.05"
              "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
              "win10, 0, 0, 0, 1"
              "gnome, 0, 0.85, 0.3, 1"
              "funky, 0.46, 0.35, -0.2, 1.2"
            ];
          # Animation configs
          animation = 
            [
              "windows, 1, 2, md3_decel, slide"
              "border, 1, 5, default"
              "workspaces, 1, 4, md3_decel, slide"
              "fadeIn, 1, 5, md3_decel"
              "fadeOut, 1, 5, md3_decel"
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
          new_is_master = true;
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
          disable_hyprland_logo = false;
          force_hypr_chan = true;
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
          "ags"
          "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        ];

    };
  };
}
