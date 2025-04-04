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

  home.stateVersion = "25.05"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true;

  home.packages = [
    pkgs.ripgrep
    # Microsoft Teams
    pkgs.teams-for-linux
    # Dia
    pkgs.dia
    # Spotify
    pkgs.spotify
    # Power Manager
    pkgs.powertop
    # Drawio
    pkgs.drawio
    # Libreoffice
    pkgs.libreoffice

    inputs.nvim.packages.x86_64-linux.default
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

  programs.bash.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
