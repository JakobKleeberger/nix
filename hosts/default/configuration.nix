# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    ../../modules/nixos/system/login-manager.nix
    ../../modules/nixos/system/polkit.nix

    inputs.home-manager.nixosModules.default

    ../../modules/nixos/util/stylix/stylix-nixos.nix
    ../../modules/nixos/util/keyd
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "libxml2-2.13.8"
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "jakob-nix-laptop"; # Define your hostname.

  services.logind.settings.Login.HandleLidSwitch = "hibernate";
  services.logind.settings.Login.HandleLidSwitchExternalPower = "suspend";
  services.logind.settings.Login.HandleLidSwitchDocked = "ignore";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      jetbrains-mono
      nerd-fonts.jetbrains-mono
      nerd-fonts.symbols-only
    ];
  };

  services.xserver.synaptics.enable = true;
  services.fwupd.enable = true;
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Enable Thunderbolt
  services.hardware.bolt.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  virtualisation.virtualbox.host = {
    enable = true;
    enableKvm = true;
    addNetworkInterface = false;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jakob = {
    isNormalUser = true;
    description = "jakob";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
  users.extraGroups.vboxusers.members = [ "jakob" ];

  programs.hyprland.enable = true;

  # Install firefox.
  programs.firefox.enable = true;

  # Documentation
  documentation.dev.enable = true;

  # Steam
  programs.steam = {
    enable = true;

    remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "jakob" = import ./home.nix;
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnsupportedSystem = true;
  nixpkgs.config.android_sdk.accept_license = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Hyprland dependencies
    waybar
    hyprlock
    hyprpaper
    hyprshot
    wofi
    # Python3
    # python312Full
    poetry
    # Audio
    pavucontrol
    #  Man Pages
    man-pages
    man-pages-posix

    # Versioning
    git
    gitui
    spotify

    # Tools
    unzip
    age
    fastfetch
    wget
    dua
    ripgrep
    coreutils
    fd

    # Polkit
    polkit_gnome
    kdePackages.polkit-kde-agent-1

    fwupd

    # Tailscale
    tailscale

    # Apps
    ghostty
    ausweisapp
    signal-desktop
    telegram-desktop
    tor-browser-bundle-bin
    discord
  ];

  # Activate Nix Flakes and nix-command
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  services.tailscale.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    22
    5555
  ];
  networking.firewall.allowedUDPPorts = [ 41641 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
