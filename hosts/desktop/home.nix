{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
<<<<<<< Updated upstream
    ../../modules/nixos/utils/stylix/stylix-home.nix
    # Fish, Yazi, Zoxide, Direnv
    ../../modules/home-manager/terminal
    # Emacs, Desktop, Environment
=======
    # ../../modules/home-manager/terminal
    ../../modules/nixos/utils/stylix/stylix-home.nix
    ../../modules/home-manager/terminal
>>>>>>> Stashed changes
    ../../modules/home-manager/utils
  ];

  home.username = "jakob";
  home.homeDirectory = "/home/jakob";

  home.stateVersion = "26.05"; # Please read the comment before changing.

  fonts.fontconfig.enable = true;

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    ripgrep
    # Spotify
    spotify
    # Power Manager
    powertop
    # jetbrains.idea
    prismlauncher

    inputs.nvim.packages.x86_64-linux.default

    # Emacs
    tree
    texlive.combined.scheme-full
  ];

  home.file = {
    ".config/hypr".source = ../../dotfiles/hypr;
    ".config/waybar".source = ../../dotfiles/waybar;
    "Pictures/wallpapers".source = ../../modules/nixos/utils/stylix/wallpapers;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.git = {
    enable = true;
    settings.user.name = "JakobKleeberger";
    settings.user.email = "kleeberger.jakob@aol.com";
    lfs.enable = true;
  };

<<<<<<< Updated upstream
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
    extraPackages = epkgs: [
      epkgs.treesit-grammars.with-all-grammars
=======
  # programs.emacs = {
  #   enable = true;
  #   package = pkgs.emacs-pgtk;
  #   extraPackages = epkgs: [
  #     epkgs.treesit-grammars.with-all-grammars

  #     pkgs.jetbrains-mono
  #     pkgs.nerd-fonts.jetbrains-mono
  #     pkgs.nerd-fonts.symbols-only
>>>>>>> Stashed changes

  #     # Rust
  #     pkgs.rust-analyzer
  #     pkgs.rustfmt
  #     pkgs.cargo
  #     pkgs.gcc_multi
  #     # Python
  #     pkgs.pyright
  #     pkgs.ruff
  #     # Nix
  #     pkgs.nil
  #     pkgs.nixd
  #     pkgs.nixdoc
  #     pkgs.nixfmt
  #     # Latex
  #     pkgs.gnuplot
  #     # Java
  #     pkgs.jdt-language-server
  #   ];
  # };

  programs.bash.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
