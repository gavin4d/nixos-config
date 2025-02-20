# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # boot.extraModulePackages = [ config.boot.kernelPackages.rtl8192eu ];

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };
  
  networking = {
    hostName = "nixos"; # Define your hostname.
    # useDHCP = false;
    # interfaces.ens3.useDHCP = false;
    nameservers = ["8.8.8.8" "1.1.1.1" "8.8.4.4"];
    networkmanager = {
      enable = true;
      #dns = "none";
    };
    firewall.allowedTCPPortRanges = [
      { from = 5001; to = 5001; }
      { from = 8080; to = 8080; }
      { from = 5201; to = 5201; }
    ];
  };
#  networking.wireless = {
#  	enable = true;  # Enables wireless support via wpa_supplicant.
#	userControlled.enable = true;
#	};

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    xkb = {
      variant = "";
      layout = "";
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.gavin4d = {
    isNormalUser = true;
    description = "gavin ford";
    extraGroups = [ "networkmanager" "wheel" "tty" "dialout" "usb" "plugdev"];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
    allowUnsupportedSystem = true;
  };

  documentation.dev.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    dig
    vim
    glibc
    man-pages
    man-pages-posix
    xdg-desktop-portal
    stdmanpages
    aspellDicts.en
    epapirus-icon-theme
    # catppuccin-papirus-folders
  ];
  
  environment.wordlist.enable = true;

  environment.sessionVariables = {
    #WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
    # QT_QPA_PLATFORM = "wayland";
    QT_QPA_PLATFORMTHEME="qt5ct";
  };

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      #font-awesome_5
      noto-fonts-cjk-sans
      nasin-nanpa
      meslo-lgs-nf
      atkinson-hyperlegible
      # opengothic
      # udev-gothic
      # yasashisa-gothic
      roboto
    ];
    fontDir.enable = true;
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        intel-ocl
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl
      ];
    };

    rtl-sdr.enable = true;

    enableAllFirmware = true;

    bluetooth.enable = true;
  };

  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
  ];
  programs.hyprlock.enable = true;

  services = {

    usbmuxd = {
      enable = true;
      package = pkgs.usbmuxd2;
    };
    # Enable CUPS to print
    printing.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    
    pipewire = {
      enable = true;
      audio.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    upower.enable = true;

    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 60;

        #Optional helps save long term battery health
        # START_CHARGE_THRESH_BAT0 = 75; # 75 and bellow it starts to charge
        # STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging

      };
    };

    # globalprotect.enable = true;

    openssh.enable = true;

    dbus.enable = true;

    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --cmd Hyprland";
          user = "greeter";
        };
      };
    };
    fprintd = {
      enable = true;
      tod = {
        enable = true;
        driver = pkgs.libfprint-2-tod1-vfs0090;
      };
    };
    udev.packages = [ pkgs.rtl-sdr ];
  };

  security.rtkit.enable = true;
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;


  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-kde
      xdg-desktop-portal-gtk
    ];
    wlr = {
      enable = true;
      settings = {
        screencast = {
          output_name = "eDP-1";
          max_fps = 30;
          chooser_type = "simple";
          chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or";
        };
      };
    };
    config.common.default = "*";
  };
  xdg.icons.enable = true;


  # services.fprintd.enable = true;
  # services.fprintd.tod.enable = true;
  # services.fprintd.tod.driver = pkgs.libfprint-2-tod1-vfs0090;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?

}
