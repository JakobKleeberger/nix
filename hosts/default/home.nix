{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ../../modules/nixos/utils/stylix/stylix-home.nix
    ../../modules/home-manager/terminal
    ../../modules/home-manager/utils
    # inputs.noctalia.homeModules.default
  ];

  home.username = "jakob";
  home.homeDirectory = "/home/jakob";

  home.stateVersion = "25.05"; # Please read the comment before changing.

  fonts.fontconfig.enable = true;

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    teams-for-linux
    spotify
    onlyoffice-desktopeditors
    jetbrains.idea-ultimate
    thunderbird
    brave
    kdePackages.dolphin

    inputs.nvim.packages.x86_64-linux.default

    tree
    pkgs.texlive.combined.scheme-full
  ];

  home.file = {
    ".config/hypr".source = ../../dotfiles/hypr;
    ".config/waybar".source = ../../dotfiles/waybar;
    # ".config/emacs".source = ../../dotfiles/emacs;
    # "Pictures/Wallpapers".source = ../../modules/nixos/util/stylix/wallpapers;
    "~/".source = ../../dotfiles/idea;
    # ".cache/noctalia/wallpapers.json" = {
    #   text = builtins.toJSON {
    #     defaultWallpaper = ../../modules/nixos/util/stylix/wallpapers/mountains.jpg;
    #     wallpapers = {
    #       "DP-1" = ../../modules/nixos/util/stylix/wallpapers/mountains.jpg;
    #     };
    #   };
    # };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.git = {
    enable = true;
    userName = "JakobKleeberger";
    userEmail = "kleeberger.jakob@aol.com";
    lfs.enable = true;
  };

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
    extraPackages = epkgs: [
      epkgs.treesit-grammars.with-all-grammars

      pkgs.jetbrains-mono
      pkgs.nerd-fonts.jetbrains-mono
      pkgs.nerd-fonts.symbols-only

      # Rust
      pkgs.rust-analyzer
      pkgs.rustfmt
      pkgs.cargo
      pkgs.gcc_multi
      # Python
      pkgs.pyright
      pkgs.ruff
      # Nix
      pkgs.nil
      pkgs.nixd
      pkgs.nixdoc
      pkgs.nixfmt-classic
      # Latex
      pkgs.gnuplot
      # Java
      pkgs.jdt-language-server
    ];
  };

  # configure options
  # programs.noctalia-shell = {
  #   enable = true;
  #   settings = {
  #     # configure noctalia here
  #     bar = {
  #       density = "compact";
  #       position = "top";
  #       floating = true;
  #       showCapsule = false;
  #       widgets = {
  #         left = [
  #           {
  #             id = "ControlCenter";
  #             useDistroLogo = true;
  #           }
  #           {
  #             hideUnoccupied = false;
  #             id = "Workspace";
  #             labelMode = "index";
  #           }
  #         ];
  #         center = [ ];
  #         right = [
  #           {
  #             id = "Network";
  #           }
  #           {
  #             id = "Bluetooth";
  #           }
  #           {
  #             alwaysShowPercentage = true;
  #             id = "Battery";
  #             warningThreshold = 30;
  #           }
  #           {
  #             formatHorizontal = "HH:mm";
  #             formatVertical = "HH mm";
  #             id = "Clock";
  #             useMonospacedFont = true;
  #             usePrimaryColor = true;
  #           }
  #         ];
  #       };
  #     };
  #     colorSchemes.predefinedScheme = "Monochrome";
  #     general = {
  #       avatarImage = "/home/drfoobar/.face";
  #       radiusRatio = 0.2;
  #     };
  #     appLauncher = {
  #       terminalCommand = "ghostty -e";
  #       viewMode = "grid";
  #       showCategories = false;
  #     };
  #     location = {
  #       name = "Bonn";
  #       weatherEnabled = true;
  #       weatherShowEffects = true;
  #       showWeekNumberInCalendar = true;
  #       showCalendarEvents = true;
  #       showCalendarWeather = false;
  #       monthBeforeDay = true;
  #       firstDayOfTheWeek = 0;
  #     };
  #     wallpaper = {
  #       enabled = true;
  #       directory = ../../modules/nixos/util/stylix/wallpapers;
  #       setWallpapersOnAllMonitors = true;
  #     };
  #   };
  #   # this may also be a string or a path to a JSON file.
  # };

  programs.bash.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
