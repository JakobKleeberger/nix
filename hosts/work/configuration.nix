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

    # ../../modules/home-manager/terminal
    ../../modules/nixos/util/stylix/stylix-nixos.nix
    ../../modules/nixos/util/keyd
    # ../../modules/home-manager/work

    ../../modules/docker/postgres/docker-compose.nix
  ];

  # Bootloader.
  # boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.useOSProber = true;

  networking.hostName = "swt-kleeberger-lx"; # Define your hostname.

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
  };

  security.polkit.enable = true;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
        if (
          subject.isInGroup("users")
            && (
              action.id == "org.freedesktop.login1.reboot" ||
              action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
              action.id == "org.freedesktop.login1.power-off" ||
              action.id == "org.freedesktop.login1.power-off-multiple-sessions"
            )
          )
        {
          return polkit.Result.YES;
        }
      });
  '';

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

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

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jakob = {
    isNormalUser = true;
    description = "jakob";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };

  programs.hyprland.enable = true;

  # Install firefox.
  programs.firefox.enable = true;

  programs.java = {
    enable = true;
    package = pkgs.jdk17;
    # package = pkgs.jdk17;
    # packages = with pkgs; [
    #   openjdk17
    #   openjdk11
    # ];
    # version = 17;
  };

  # Documentation
  documentation.dev.enable = true;

  home-manager.backupFileExtension = "backup";

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "jakob" = import ./home.nix;
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnsupportedSystem = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Hyprland dependencies
    waybar
    hyprpaper
    hyprlock
    wofi
    wayvnc
    # Bluetooth Manager
    # Python3
    python312Full
    poetry
    # Audio
    pavucontrol
    #  Man Pages
    man-pages
    man-pages-posix
    # Intellij
    jetbrains.idea-ultimate

    # Java
    # openjdk17
    maven
    kdePackages.partitionmanager
    unzip

    # Git
    git
    git-lfs
    age
    neofetch
    wget
    polkit_gnome

    # Create an FHS environment using the command `fhs`, enabling the execution of non-NixOS packages in NixOS!
    (
      let
        base = pkgs.appimageTools.defaultFhsEnvArgs;
      in
      pkgs.buildFHSUserEnv (base
        // {
        name = "fhs";
        targetPkgs = pkgs:
          # pkgs.buildFHSUserEnv provides only a minimal FHS environment,
          # lacking many basic packages needed by most software.
          # Therefore, we need to add them manually.
          #
          # pkgs.appimageTools provides basic packages required by most software.
          (base.targetPkgs pkgs)
            ++ (
            with pkgs; [
              pkg-config
              ncurses
              # Feel free to add more packages here if needed.
            ]
          );
        profile = "export FHS=1";
        runScript = "bash";
        extraOutputsToInstall = [ "dev" ];
      })
    )
  ];

  environment.sessionVariables = rec {
    SEDNA_DEPLOYMENT_DIRECTORY = "$HOME/dev/runtime/wildfly/wildfly-32.0.1/standalone/deployments";

    SEDNA_VERSION = "/home/jakob/dev/swt.products.sedna";
    WILDFLY_VERSION = "32.0.1";

    RC_CUSTOMER_NAME = "pgsednatrunk";
    RC_XA_DATASOURCE = "java:/pgsednatrunk";
    RC_CSB_PORT = 8080;

    RC_CSB_HOST = "swt-kleeberger-lx";
    RC_NAMESPACE = "$RC_CUSTOMER_NAME";
    RC_DATABASE = "PostgreSQL";

    #RC_STORAGE_SERVICE_NAME=storage
    #RC_FS_STORAGE_ADAPTER_NAME=fsStorageAdapter
    #RC_FS_STORAGE_ADAPTER_PATH=D:\SEDNA-FileSystemStorage-common
    #RC_DATASTORE_NAME=datastore
    #RC_REPOSITORY_NAME=DEFA2DB

    RC_AGENT_SERVICE_NAME = "AgentServer";
    RC_AGENT_SERVICE_PORT = 8070;

    RC_CSB_SINCE_4_2 = "TRUE";

    # Not officially in the specification
    # XDG_BIN_HOME    = "$HOME/.local/bin";
    # PATH = [
    #   "${XDG_BIN_HOME}"
    # ];
  };

  environment.shellAliases = {
    csbcmd = "$SEDNA_VERSION/DOXiS4-CSBcmd/assemble/target/dist/csbcmd";
    administration-server = "$SEDNA_VERSION/SEDNA-Administration/server/assemble/target/dist/DOXiS4CSBAdminServer";
    administration-client = "$SEDNA_VERSION/SEDNA-Administration/client/assemble/target/dist/DOXiS4CSBAdminClient";
    agentserver = "$SEDNA_VERSION/SEDNA-AgentServer/agentserver-assembly/target/dist/DOXiS4CSBAgentServer";
    ft = "$SEDNA_VERSION/SEDNA-FT/assemble/target/dist/DOXiS4-FT";
    fips = "$SEDNA_VERSION/SEDNA-Fips/assembly/target/dist/server/DOXiS4-Fips";
    wildfly = "cd ~/dev/runtime/wildfly/wildfly-$WILDFLY_VERSION/bin && ./standalone.sh";
  };

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

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 5900 ];
  networking.firewall.allowedUDPPorts = [ 5900 ];
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
