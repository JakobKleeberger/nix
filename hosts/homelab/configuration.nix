# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config
, pkgs
, inputs
, ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default

    ../../modules/nixos/util/bottom.nix

    ../../modules/nixos/util/keyd
    # ../../modules/nixos/hosting/jellyfin.nix
    # ../../modules/nixos/hosting/adguard.nix

    ../../servers/glance/docker-compose.nix
    ../../servers/actual-budget/docker-compose.nix
    ../../servers/paperless/docker-compose.nix
    # ../../servers/viewtube/docker-compose.nix
  ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/nvme0n1";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "homelab"; # Define your hostname.
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
      "homelab" = import ./home.nix;
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.homelab = {
    isNormalUser = true;
    description = "homelab";
    <<<<<<< HEAD
      extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [ ];
    =======
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ ];
    <<<<<<< HEAD
      >>>>>>> 18c7737 (Revert "added tailscale to homelab")
      };
      ====== =
      };
    >>>>>>> c8af4c1 (Reapply "added tailscale to homelab")

    # Enable automatic login for the user.
    services.getty.autologinUser = "homelab";

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    <<<<<<< HEAD
      # List packages installed in system profile. To search, run:
      # $ nix search wget
      environment.systemPackages = with pkgs; [
      #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      #  wget
      neovim
      git
    ];
    =======
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
      #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      #  wget
      neovim
      git
      tailscale
    ];
    >>>>>>> c8af4c1 (Reapply "added tailscale to homelab")

    # Activate Nix Flakes and nix-command
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    <<<<<<< HEAD
      # List services that you want to enable:

      # Enable the OpenSSH daemon.
      # services.openssh.enable = true;

      # Open ports in the firewall.
      <<<<<<< HEAD
      networking.firewall.allowedTCPPorts = [
      # SSH
      22
      # Website Landing Page
      8080
      80
      # Keine Ahnung
      5006
      # Viewtube
      8066
    ];
    networking.firewall.allowedUDPPorts = [
      # Tailscale
      41641
    ];

    =======
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    >>>>>>> 18c7737 (Revert "added tailscale to homelab")
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
  == =====
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Tailscale
  services.tailscale = {
    enable = true;
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 ];
  networking.firewall.allowedUDPPorts = [ 41641 ];

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
> > > >>>> c8af4c1 (Reapply "added tailscale to homelab")
