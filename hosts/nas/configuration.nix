# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config
, pkgs
, inputs
, ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default

    ../../modules/nixos/util/bottom.nix

    ../../modules/nixos/util/keyd
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nas"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

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

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "de";

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "nas" = import ./home.nix;
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nas = {
    isNormalUser = true;
    description = "nas";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [ ];
  };

  # Enable automatic login for the user.
  services.getty.autologinUser = "nas";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = false;

  environment.systemPackages = with pkgs; [
    neovim
    git
    tailscale
    btrfs-progs
  ];

  # Activate Nix Flakes and nix-command
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud30;
    hostName = "localhost";
    home = "/mnt/raid/nextcloud";
    appstoreEnable = true;
    config.adminpassFile = "/etc/nextcloud-admin-pass";
    settings = {
      trusted_domains = [ "*" ];
    };
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Tailscale
  services.tailscale = {
    enable = true;
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    # SSH
    22
    # Website Landing Page
    8080
    80
  ];
  networking.firewall.allowedUDPPorts = [
    # Tailscale
    41641
  ];

  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
