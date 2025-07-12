{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ../../modules/nixos/utils/stylix/stylix-home.nix
    # Fish, Yazi, Zoxide, Direnv
    ../../modules/home-manager/terminal
    # Emacs, Desktop, Environment
    ../../modules/home-manager/utils
  ];

  home.username = "jakob";
  home.homeDirectory = "/home/jakob";

  home.stateVersion = "26.05"; # Please read the comment before changing.

  fonts.fontconfig.enable = true;

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    ripgrep
    # Microsoft Teams
    teams-for-linux
    # Dia
    dia
    # Spotify
    spotify
    # Power Manager
    powertop
    # Drawio
    drawio
    jetbrains.idea-ultimate
    prismlauncher

    inputs.nvim.packages.x86_64-linux.default

    # Emacs
    tree
    texlive.combined.scheme-full
  ];

  home.file = {
    ".config/hypr".source = ../../dotfiles/hypr;
    ".config/waybar".source = ../../dotfiles/waybar;
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
