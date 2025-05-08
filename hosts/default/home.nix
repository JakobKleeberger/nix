{ pkgs
, inputs
, ...
}: {
  imports = [
    ../../modules/nixos/util/stylix/stylix-home.nix
    ../../modules/home-manager/terminal
  ];

  home.username = "jakob";
  home.homeDirectory = "/home/jakob";

  home.stateVersion = "25.05"; # Please read the comment before changing.

  fonts.fontconfig.enable = true;

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    teams-for-linux
    spotify
    libreoffice

    inputs.nvim.packages.x86_64-linux.default

    # Emacs
    tree
    pkgs.texlive.combined.scheme-full
  ];

  home.file = {
    ".config/hypr".source = ../../dotfiles/hypr;
    ".config/waybar".source = ../../dotfiles/waybar;
    # ".config/emacs".source = ../../dotfiles/emacs;
    "Pictures/wallpapers".source = ../../modules/nixos/util/stylix/wallpapers;
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

  programs.bash.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
