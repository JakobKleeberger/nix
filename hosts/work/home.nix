{ config
, pkgs
, inputs
, ...
}: {
  imports = [
    # ../../modules/home-manager/terminal
    ../../modules/nixos/util/stylix/stylix-home.nix
    ../../modules/home-manager/terminal
  ];

  home.username = "jakob";
  home.homeDirectory = "/home/jakob";

  home.stateVersion = "24.05"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    ripgrep
    # Microsoft Teams
    teams-for-linux
    # Spotify
    spotify
    # Ressource Monitor
    bottom
    # Keepass
    keepassxc
    # Brave
    brave
    
    vmware-workstation

    inputs.nvim.packages.x86_64-linux.default

    tree
    pkgs.texlive.combined.scheme-full
  ];

  home.file = {
    ".config/hypr".source = ../../dotfiles/hypr;
    ".config/waybar".source = ../../dotfiles/waybar;
    "Pictures/wallpapers".source = ../../modules/nixos/util/stylix/wallpapers;
    "~/".source = ../../dotfiles/idea;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
    # package = pkgs.emacs-nox;
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


  programs.bash.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
